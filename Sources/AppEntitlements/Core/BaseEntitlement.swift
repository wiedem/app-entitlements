public enum BaseEntitlement: String, Sendable {
    // MARK: - Application Identifiers

    #if os(macOS)
    /// Application identifier (macOS)
    case applicationIdentifier = "com.apple.application-identifier"
    #else
    /// Application identifier (iOS)
    case applicationIdentifier = "application-identifier"
    #endif

    /// Developer team identifier
    case teamIdentifier = "com.apple.developer.team-identifier"

    // MARK: - Access Groups & Sharing

    /// Keychain access groups
    ///
    /// - SeeAlso: [Keychain Access Groups](https://developer.apple.com/documentation/bundleresources/entitlements/keychain-access-groups)
    case keychainAccessGroups = "keychain-access-groups"

    /// Application groups for shared containers
    ///
    /// - SeeAlso: [App Groups](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_security_application-groups)
    case applicationGroups = "com.apple.security.application-groups"

    /// Associated domains
    ///
    /// - SeeAlso: [Associated Domains](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains)
    case associatedDomains = "com.apple.developer.associated-domains"

    // MARK: - Push Notifications

    /// APS (Apple Push Service) environment
    ///
    /// - SeeAlso: [APS Environment](https://developer.apple.com/documentation/bundleresources/entitlements/aps-environment)
    case apsEnvironment = "aps-environment"

    // MARK: - Data Protection

    /// Default data protection level
    ///
    /// - SeeAlso: [Data Protection](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_default-data-protection)
    case defaultDataProtection = "com.apple.developer.default-data-protection"

    // MARK: - Device Check

    /// Device Check App Attest environment
    ///
    /// - SeeAlso: [App Attest Environment](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_devicecheck_appattest-environment)
    case deviceCheckAppAttestEnvironment = "com.apple.developer.devicecheck.appattest-environment"

    // MARK: - iCloud

    /// iCloud container identifiers
    ///
    /// - SeeAlso: [iCloud Container Identifiers](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_icloud-container-identifiers)
    case iCloudContainerIdentifiers = "com.apple.developer.icloud-container-identifiers"

    /// iCloud container environment
    ///
    /// - SeeAlso: [iCloud Container Environment](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_icloud-container-environment)
    case iCloudContainerEnvironment = "com.apple.developer.icloud-container-environment"

    /// iCloud key-value store
    ///
    /// - SeeAlso: [iCloud Key-Value Store](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_ubiquity-kvstore-identifier)
    case iCloudKeyValueStore = "com.apple.developer.ubiquity-kvstore-identifier"

    /// iCloud services
    ///
    /// - SeeAlso: [iCloud Services](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_icloud-services)
    case iCloudServices = "com.apple.developer.icloud-services"

    // MARK: - Debugging & Development

    #if os(macOS)
    /// Get task allow (allows debugging) - macOS uses full key
    case getTaskAllow = "com.apple.security.get-task-allow"

    /// Debugger entitlement (macOS)
    case debugger = "com.apple.security.cs.debugger"
    #else
    /// Get task allow (allows debugging) - iOS uses short key
    case getTaskAllow = "get-task-allow"
    #endif
}

extension BaseEntitlement: EntitlementIdentifying {
    public var entitlementID: String {
        rawValue
    }
}
