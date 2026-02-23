// MARK: - Application Identifiers

public extension AppEntitlements {
    /// The application's unique identifier.
    ///
    /// Combines the team ID prefix with the bundle identifier.
    static var applicationIdentifier: String? {
        get throws {
            try AppEntitlements.getValue(for: BaseEntitlement.applicationIdentifier)
        }
    }

    /// The developer team identifier.
    static var teamIdentifier: String? {
        get throws {
            try AppEntitlements.getValue(for: BaseEntitlement.teamIdentifier)
        }
    }
}

// MARK: - Access Groups & Sharing

public extension AppEntitlements {
    /// Keychain access groups for sharing keychain items.
    ///
    /// See [Keychain Access Groups](https://developer.apple.com/documentation/bundleresources/entitlements/keychain-access-groups)
    static var keychainAccessGroups: [String]? {
        get throws {
            try AppEntitlements.getArray(for: BaseEntitlement.keychainAccessGroups)
        }
    }

    /// Application groups for sharing data between apps.
    ///
    /// See [App Groups](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_security_application-groups)
    static var applicationGroups: [String]? {
        get throws {
            try AppEntitlements.getArray(for: BaseEntitlement.applicationGroups)
        }
    }
}

// MARK: - Debugging & Development

public extension AppEntitlements {
    /// Allows debugger attachment and task inspection.
    ///
    /// Automatically added to development builds. On iOS and tvOS, this is `get-task-allow`.
    /// On macOS, this controls whether debugging tools can attach to the process.
    static var getTaskAllow: Bool? {
        get throws {
            try AppEntitlements.getValue(for: BaseEntitlement.getTaskAllow)
        }
    }
}
