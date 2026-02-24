public import Foundation

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

    /// Associated domains for universal links and other domain associations.
    ///
    /// See [Associated Domains](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains)
    static var associatedDomains: [String]? {
        get throws {
            try AppEntitlements.getArray(for: BaseEntitlement.associatedDomains)
        }
    }
}

// MARK: - Push Notifications

public extension AppEntitlements {
    /// The Apple Push Notification service environment.
    ///
    /// See [APS Environment](https://developer.apple.com/documentation/bundleresources/entitlements/aps-environment)
    static var apsEnvironment: ApsEnvironment? {
        get throws {
            try AppEntitlements.getValue(for: BaseEntitlement.apsEnvironment)
        }
    }
}

// MARK: - Data Protection

public extension AppEntitlements {
    /// The default data protection level for files.
    ///
    /// See [Data Protection](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_default-data-protection)
    static var defaultDataProtection: FileProtectionType? {
        get throws {
            try AppEntitlements.getValue(for: BaseEntitlement.defaultDataProtection)
        }
    }
}

// MARK: - Device Check

public extension AppEntitlements {
    /// The Device Check App Attest environment.
    ///
    /// See [App Attest Environment](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_devicecheck_appattest-environment)
    static var deviceCheckAppAttestEnvironment: AppAttestEnvironment? {
        get throws {
            try AppEntitlements.getValue(for: BaseEntitlement.deviceCheckAppAttestEnvironment)
        }
    }
}

// MARK: - iCloud

public extension AppEntitlements {
    /// iCloud container identifiers.
    ///
    /// See [iCloud Container Identifiers](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_icloud-container-identifiers)
    static var iCloudContainerIdentifiers: [String]? {
        get throws {
            try AppEntitlements.getArray(for: BaseEntitlement.iCloudContainerIdentifiers)
        }
    }

    /// The iCloud container environment.
    ///
    /// See [iCloud Container Environment](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_icloud-container-environment)
    static var iCloudContainerEnvironment: ICloudContainerEnvironment? {
        get throws {
            try AppEntitlements.getValue(for: BaseEntitlement.iCloudContainerEnvironment)
        }
    }

    /// The iCloud key-value store identifier.
    ///
    /// See [iCloud Key-Value Store](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_ubiquity-kvstore-identifier)
    static var iCloudKeyValueStore: String? {
        get throws {
            try AppEntitlements.getValue(for: BaseEntitlement.iCloudKeyValueStore)
        }
    }

    /// The iCloud services enabled for the app.
    ///
    /// See [iCloud Services](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_icloud-services)
    static var iCloudServices: [ICloudService]? {
        get throws {
            try AppEntitlements.getArray(for: BaseEntitlement.iCloudServices)
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
