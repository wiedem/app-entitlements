public extension AppEntitlements {
    /// Errors that can occur when accessing entitlements.
    enum EntitlementsError: Error, Sendable {
        #if os(macOS)
        /// Failed to create a security task for the current process.
        ///
        /// This can occur if the process has an invalid code signature or insufficient permissions.
        case failedToCreateSecurityTask
        #endif

        /// Failed to load the executable symbol from the Mach-O binary.
        case failedToLoadExecutableSymbol(String)

        /// Failed to load the library.
        case failedToLoadLibrary(String)

        /// Failed to read entitlements from the application binary.
        ///
        /// This wraps underlying errors from parsing, decoding, or accessing the Mach-O binary.
        /// Check the associated error for specific failure details.
        case failedToReadEntitlements(any Error)
    }
}
