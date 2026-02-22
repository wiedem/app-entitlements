internal import AppEntitlementsCore
internal import AppEntitlementsMacros

// MARK: - Application Identifiers

public extension AppEntitlements {
    /// The application's unique identifier.
    ///
    /// Combines the team ID prefix with the bundle identifier.
    @Entitlement(BaseEntitlement.applicationIdentifier)
    static var applicationIdentifier: String?

    /// The developer team identifier.
    @Entitlement(BaseEntitlement.teamIdentifier)
    static var teamIdentifier: String?
}

// MARK: - Access Groups & Sharing

public extension AppEntitlements {
    /// Keychain access groups for sharing keychain items.
    ///
    /// See [Keychain Access Groups](https://developer.apple.com/documentation/bundleresources/entitlements/keychain-access-groups)
    @Entitlement(BaseEntitlement.keychainAccessGroups)
    static var keychainAccessGroups: [String]?

    /// Application groups for sharing data between apps.
    ///
    /// See [App Groups](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_security_application-groups)
    @Entitlement(BaseEntitlement.applicationGroups)
    static var applicationGroups: [String]?
}

// MARK: - Debugging & Development

public extension AppEntitlements {
    /// Allows debugger attachment and task inspection.
    ///
    /// Automatically added to development builds. On iOS and tvOS, this is `get-task-allow`.
    /// On macOS, this controls whether debugging tools can attach to the process.
    @Entitlement(BaseEntitlement.getTaskAllow)
    static var getTaskAllow: Bool?
}
