internal import MachO

extension MachO {
    struct UnsafeMachHeader {
        let baseAddress: UnsafeRawPointer
        let headerMagic: HeaderMagic
        let loadCommands: UnsafeLoadCommands

        init(baseAddress: UnsafeRawPointer) throws {
            self.baseAddress = baseAddress

            let machHeaderMagic = baseAddress.assumingMemoryBound(to: UInt32.self)
            guard let headerMagic = HeaderMagic(rawValue: machHeaderMagic.pointee) else {
                throw DataError.invalidMachHeader
            }
            self.headerMagic = headerMagic

            switch headerMagic {
            case .magic:
                let machHeader = baseAddress.assumingMemoryBound(to: mach_header.self)
                loadCommands = UnsafeLoadCommands(machHeader: machHeader)

            case .magic64:
                let machHeader = baseAddress.assumingMemoryBound(to: mach_header_64.self)
                loadCommands = UnsafeLoadCommands(machHeader: machHeader)

            case .fat, .fat64:
                throw DataError.fatBinary
            }
        }

        init(baseAddress: UnsafeRawPointer, bufferSize: Int) throws {
            self.baseAddress = baseAddress

            guard bufferSize >= MemoryLayout<UInt32>.size else {
                throw DataError.truncatedData
            }

            let machHeaderMagic = baseAddress.assumingMemoryBound(to: UInt32.self)
            guard let headerMagic = HeaderMagic(rawValue: machHeaderMagic.pointee) else {
                throw DataError.invalidMachHeader
            }
            self.headerMagic = headerMagic

            switch headerMagic {
            case .magic:
                guard bufferSize >= MemoryLayout<mach_header>.size else {
                    throw DataError.truncatedData
                }
                let machHeader = baseAddress.assumingMemoryBound(to: mach_header.self)
                guard MemoryLayout<mach_header>.size + Int(machHeader.pointee.sizeofcmds) <= bufferSize else {
                    throw DataError.truncatedData
                }
                loadCommands = UnsafeLoadCommands(machHeader: machHeader)

            case .magic64:
                guard bufferSize >= MemoryLayout<mach_header_64>.size else {
                    throw DataError.truncatedData
                }
                let machHeader = baseAddress.assumingMemoryBound(to: mach_header_64.self)
                guard MemoryLayout<mach_header_64>.size + Int(machHeader.pointee.sizeofcmds) <= bufferSize else {
                    throw DataError.truncatedData
                }
                loadCommands = UnsafeLoadCommands(machHeader: machHeader)

            case .fat, .fat64:
                throw DataError.fatBinary
            }
        }
    }
}

func segmentName(of segment: segment_command_64) -> String {
    withUnsafePointer(to: segment.segname) { pointer in
        let cString = pointer.pointer(to: \.0)!
        return String(cString: cString)
    }
}

func segmentName(of segment: segment_command) -> String {
    withUnsafePointer(to: segment.segname) { pointer in
        let cString = pointer.pointer(to: \.0)!
        return String(cString: cString)
    }
}
