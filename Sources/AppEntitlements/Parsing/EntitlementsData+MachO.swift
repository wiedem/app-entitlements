internal import Foundation
internal import MachO

extension AppEntitlements.EntitlementsData {
    static func make(from machHeader: MachO.UnsafeMachHeader) -> Self {
        var slide: Int?
        var commandDataOffset: Int?
        var segmentOffset: Int?
        var segmentDataPointer: UnsafeRawPointer?
        var entitlementsSectionData: Data?

        // Process all MachO load commands to get the necessary code signing data for the entitlements.
        for command in machHeader.loadCommands {
            let rawPointer = UnsafeRawPointer(command)

            switch command.pointee.cmd {
            case UInt32(LC_CODE_SIGNATURE):
                let linkEditData = UnsafeRawPointer(command).assumingMemoryBound(to: linkedit_data_command.self)
                commandDataOffset = Int(linkEditData.pointee.dataoff)

            case UInt32(LC_SEGMENT):
                let segment = rawPointer.assumingMemoryBound(to: segment_command.self)
                switch segmentName(of: segment.pointee) {
                case SEG_TEXT:
                    let currentSlide = Int(bitPattern: machHeader.baseAddress - Int(segment.pointee.vmaddr))
                    slide = currentSlide
                    entitlementsSectionData = MachO.segmentSectionData(
                        of: segment,
                        sectionName: "__entitlements",
                        slide: currentSlide
                    )

                case SEG_LINKEDIT:
                    segmentOffset = Int(segment.pointee.fileoff)
                    segmentDataPointer = UnsafeRawPointer(bitPattern: Int(segment.pointee.vmaddr))

                default:
                    break
                }

            case UInt32(LC_SEGMENT_64):
                let segment = rawPointer.assumingMemoryBound(to: segment_command_64.self)
                switch segmentName(of: segment.pointee) {
                case SEG_TEXT:
                    let currentSlide = Int(bitPattern: machHeader.baseAddress - Int(segment.pointee.vmaddr))
                    slide = currentSlide
                    entitlementsSectionData = MachO.segmentSectionData(
                        of: segment,
                        sectionName: "__entitlements",
                        slide: currentSlide
                    )

                case SEG_LINKEDIT:
                    segmentOffset = Int(segment.pointee.fileoff)
                    segmentDataPointer = UnsafeRawPointer(bitPattern: Int(segment.pointee.vmaddr))

                default:
                    break
                }

            default:
                continue
            }

            // Check if the Entitlements data is complete.
            if let slide, let commandDataOffset, let segmentOffset, let segmentDataPointer {
                let codeSigningDataPointer = segmentDataPointer + slide + commandDataOffset - segmentOffset

                var entitlementsData: Data?
                var entitlementsDataDER: Data?

                if let superBlob = CodeSigning.UnsafeSuperBlob(baseAddress: codeSigningDataPointer) {
                    (entitlementsData, entitlementsDataDER) = extractEntitlementsBlobs(from: superBlob)
                }

                return .init(
                    linkEditData: entitlementsData,
                    linkEditDataDER: entitlementsDataDER,
                    textSectionData: entitlementsSectionData
                )
            }
        }

        return .none
    }
}

private extension AppEntitlements.EntitlementsData {
    static func extractEntitlementsBlobs(
        from superBlob: CodeSigning.UnsafeSuperBlob
    ) -> (plist: Data?, der: Data?) {
        let plist = superBlob.blobs.first(where: { $0.magic == .entitlement })?.blobData
        let der = superBlob.blobs.first(where: { $0.magic == .entitlementDER })?.blobData
        return (plist, der)
    }
}

extension AppEntitlements.EntitlementsData {
    static func make(fromMachOFileData baseAddress: UnsafeRawPointer, bufferSize: Int) throws -> Self {
        let machHeader = try MachO.UnsafeMachHeader(baseAddress: baseAddress, bufferSize: bufferSize)

        for command in machHeader.loadCommands {
            switch command.pointee.cmd {
            case UInt32(LC_CODE_SIGNATURE):
                let linkEditData = UnsafeRawPointer(command).assumingMemoryBound(to: linkedit_data_command.self)
                let codeSignatureOffset = Int(linkEditData.pointee.dataoff)
                let codeSignatureDeclaredSize = Int(linkEditData.pointee.datasize)

                guard codeSignatureOffset >= 0, codeSignatureOffset < bufferSize else {
                    throw MachO.DataError.truncatedData
                }

                let codeSignatureSize = min(bufferSize - codeSignatureOffset, codeSignatureDeclaredSize)
                guard codeSignatureSize > 0 else {
                    throw MachO.DataError.truncatedData
                }

                let codeSigningDataPointer = baseAddress + codeSignatureOffset
                var entitlementsData: Data?
                var entitlementsDataDER: Data?

                if let superBlob = CodeSigning.UnsafeSuperBlob(baseAddress: codeSigningDataPointer, containerSize: codeSignatureSize) {
                    (entitlementsData, entitlementsDataDER) = extractEntitlementsBlobs(from: superBlob)
                }

                return .init(
                    linkEditData: entitlementsData,
                    linkEditDataDER: entitlementsDataDER,
                    textSectionData: nil
                )
            default:
                continue
            }
        }

        return .none
    }
}
