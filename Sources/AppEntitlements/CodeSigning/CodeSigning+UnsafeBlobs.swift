internal import Foundation

extension CodeSigning {
    struct UnsafeBlob {
        private let baseAddress: UnsafeRawPointer
        private let header: UnsafePointer<Header>

        let magic: Magic

        var blobData: Data {
            guard header.pointee.blobLength > 0 else {
                return Data()
            }

            let dataPointer = UnsafeRawPointer(header.advanced(by: 1))
            let dataLength = Int(header.pointee.blobLength) - baseAddress.distance(to: dataPointer)

            return Data(
                bytesNoCopy: UnsafeMutableRawPointer(mutating: dataPointer),
                count: dataLength,
                deallocator: .none
            )
        }

        init?(baseAddress: UnsafeRawPointer) {
            self.baseAddress = baseAddress
            header = baseAddress.assumingMemoryBound(to: Header.self)

            guard let magic = Magic(rawValue: header.pointee.magic) else {
                return nil
            }
            self.magic = magic
        }
    }
}

private extension CodeSigning.UnsafeBlob {
    struct Header {
        private let _magic: CodeSigning.Magic.RawValue
        private let _blobLength: UInt32

        var magic: CodeSigning.Magic.RawValue {
            _magic.bigEndian
        }

        var blobLength: UInt32 {
            _blobLength.bigEndian
        }
    }
}

extension CodeSigning {
    struct UnsafeSuperBlob {
        private let baseAddress: UnsafeRawPointer
        private let header: UnsafePointer<Header>

        let magic: Magic
        let blobs: [UnsafeBlob]

        init?(baseAddress: UnsafeRawPointer) {
            self.baseAddress = baseAddress
            header = baseAddress.assumingMemoryBound(to: Header.self)

            guard let magic = Magic(rawValue: header.pointee.magic) else {
                return nil
            }
            self.magic = magic

            let indicesPointer = UnsafeRawPointer(header.advanced(by: 1))
                .assumingMemoryBound(to: BlobIndex.self)

            let codeSigningIndices = UnsafeBufferPointer(
                start: indicesPointer,
                count: Int(header.pointee.indicesCount)
            )

            blobs = codeSigningIndices.compactMap { index in
                UnsafeBlob(baseAddress: baseAddress + Int(index.offset))
            }
        }
    }
}

private extension CodeSigning.UnsafeSuperBlob {
    struct Header {
        private let _magic: CodeSigning.Magic.RawValue
        private let _totalLength: UInt32
        private let _indicesCount: UInt32

        var magic: CodeSigning.Magic.RawValue {
            _magic.bigEndian
        }

        var totalLength: UInt32 {
            _totalLength.bigEndian
        }

        var indicesCount: UInt32 {
            _indicesCount.bigEndian
        }
    }
}

private extension CodeSigning {
    struct BlobIndex {
        private let _type: UInt32
        private let _offset: UInt32

        var type: UInt32 {
            _type.bigEndian
        }

        var offset: UInt32 {
            _offset.bigEndian
        }
    }
}
