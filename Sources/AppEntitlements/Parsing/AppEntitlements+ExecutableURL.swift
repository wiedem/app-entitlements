public import Foundation

public extension AppEntitlements {
    /// Reads entitlements from a Mach-O executable on disk.
    ///
    /// This method parses the code signature of an executable file and extracts
    /// its entitlements. It supports both PropertyList and DER-encoded entitlements.
    /// The file is accessed using memory-mapped I/O for efficient reading of large executables.
    ///
    /// - Parameter url: File URL to the Mach-O executable.
    /// - Returns: A dictionary of entitlements with their values. Returns an empty dictionary
    ///   if the executable has no entitlements or no code signature.
    /// - Throws: ``EntitlementsError/failedToReadEntitlements(_:)`` if the file cannot
    ///   be read, is not a valid Mach-O binary, or is a universal (fat) binary.
    ///
    /// - Note: Only single-architecture Mach-O binaries are supported. Universal (fat)
    ///   binaries containing multiple architectures will result in an error. Use tools
    ///   like `lipo` to extract a specific architecture before reading entitlements.
    ///
    /// - SeeAlso: [Code Signing](https://developer.apple.com/documentation/security/code_signing_services)
    static func entitlements(fromExecutableAt url: URL) throws(EntitlementsError) -> [String: PropertyListValue] {
        do {
            // Use memory-mapped I/O for efficient reading of large executable files
            let data = try Data(contentsOf: url, options: .alwaysMapped)
            return try data.withUnsafeBytes { rawBuffer -> [String: PropertyListValue] in
                guard let baseAddress = rawBuffer.baseAddress, rawBuffer.count > 0 else {
                    throw EntitlementsError.failedToReadEntitlements(MachO.DataError.invalidMachHeader)
                }
                let entitlementsData = try EntitlementsData.make(fromMachOFileData: baseAddress)
                return try entitlementsData.decode()
            }
        } catch let error as EntitlementsError {
            throw error
        } catch {
            throw EntitlementsError.failedToReadEntitlements(error)
        }
    }
}
