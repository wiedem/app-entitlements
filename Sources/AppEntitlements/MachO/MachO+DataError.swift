public extension MachO {
    /// Errors that can occur when parsing Mach-O binary data.
    enum DataError: Error, Sendable {
        /// The Mach-O header is invalid or malformed.
        case invalidMachHeader
        /// The binary is a fat (universal) binary which is not supported.
        ///
        /// Fat binaries contain multiple architectures. Use `lipo -thin <arch>` to extract
        /// a specific architecture before parsing.
        case fatBinary
        /// The segment structure in the Mach-O binary is unexpected or invalid.
        case unexpectedSegmentStructure
    }
}
