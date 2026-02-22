public extension AppEntitlements {
    /// Errors that can occur when encoding or decoding DER-formatted entitlements.
    enum DEREncodingError: Error, Sendable {
        /// The DER encoding version is not supported.
        case unsupportedVersion

        /// The entitlement data is invalid.
        case invalidEntitlementData

        /// The entitlement data format is not supported.
        case unsupportedEntitlementData

        /// The property list value type is not supported for DER encoding.
        case unsupportedPropertyListValue
    }
}
