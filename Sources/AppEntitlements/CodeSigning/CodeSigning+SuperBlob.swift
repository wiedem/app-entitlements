extension CodeSigning {
    struct SuperBlob {
        let magic: UInt32
        let totalLength: UInt32
        let indicesCount: UInt32
    }
}
