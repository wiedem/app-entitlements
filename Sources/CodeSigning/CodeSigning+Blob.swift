internal import Foundation

extension CodeSigning {
    struct Blob {
        let magic: Magic
        let dataPointer: UnsafeRawPointer
        let dataLength: Int

        func data() -> Data {
            Data(bytes: dataPointer, count: dataLength)
        }
    }
}
