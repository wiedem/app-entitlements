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
    case keychainAccessGroups = "keychain-access-groups"

    /// Application groups for shared containers
    case applicationGroups = "com.apple.security.application-groups"

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
