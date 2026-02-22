internal import AppEntitlementsCore
internal import AppEntitlementsMacros

// MARK: - Authentication

public extension AppEntitlements {
    /// Sign in with Apple Entitlement.
    ///
    /// See [Sign in with Apple Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.applesignin)
    @Entitlement(.signInWithApple)
    static var signInWithApple: [String]?

    /// AutoFill Credential Provider Entitlement.
    ///
    /// See [AutoFill Credential Provider Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.authentication-services.autofill-credential-provider)
    @Entitlement(.autoFillCredentialProvider)
    static var autoFillCredentialProvider: Bool?
}

@available(iOS 26.0, macOS 26.0, *)
public extension AppEntitlements {
    /// Account Creation Requires Phone Number.
    ///
    /// See [Account Creation Requires Phone Number](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.authentication-services.account-creation-requires-phone-number)
    @Entitlement(.authenticationServicesAccountCreationRequiresPhoneNumber)
    static var authenticationServicesAccountCreationRequiresPhoneNumber: Bool?
}

// MARK: - CloudKit

@available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *)
public extension AppEntitlements {
    /// com.apple.developer.icloud-extended-share-access.
    ///
    /// See [com.apple.developer.icloud-extended-share-access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.icloud-extended-share-access)
    @Entitlement(.iCloudExtendedShareAccess)
    static var iCloudExtendedShareAccess: [String]?
}

// MARK: - Contacts

@available(iOS 15.0, macOS 13.0, *)
public extension AppEntitlements {
    /// com.apple.developer.contacts.notes.
    ///
    /// See [com.apple.developer.contacts.notes](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.contacts.notes)
    @Entitlement(.contactsNotes)
    static var contactsNotes: Bool?
}

// MARK: - Declared Age Range

@available(iOS 26.0, macOS 26.0, *)
public extension AppEntitlements {
    /// com.apple.developer.declared-age-range.
    ///
    /// See [com.apple.developer.declared-age-range](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.declared-age-range)
    @Entitlement(.declaredAgeRange)
    static var declaredAgeRange: Bool?
}

// MARK: - Device Management

public extension AppEntitlements {
    /// Enrollment Single Sign On.
    ///
    /// See [Enrollment Single Sign On](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.enrollment-sso-capable)
    @Entitlement(.enrollmentSsoCapable)
    static var enrollmentSsoCapable: Bool?
}

// MARK: - Education

public extension AppEntitlements {
    /// ClassKit Environment Entitlement.
    ///
    /// See [ClassKit Environment Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.classkit-environment)
    @Entitlement(.classKitEnvironment)
    static var classKitEnvironment: ClassKitEnvironment?

    /// com.apple.developer.automatic-assessment-configuration.
    ///
    /// See [com.apple.developer.automatic-assessment-configuration](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.automatic-assessment-configuration)
    @Entitlement(.automaticAssessmentConfiguration)
    static var automaticAssessmentConfiguration: Bool?
}

// MARK: - File provider

public extension AppEntitlements {
    /// com.apple.developer.fileprovider.testing-mode.
    ///
    /// See [com.apple.developer.fileprovider.testing-mode](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.fileprovider.testing-mode)
    @Entitlement(.fileproviderTestingMode)
    static var fileproviderTestingMode: Bool?
}

// MARK: - FinanceKit

public extension AppEntitlements {
    /// FinanceKit.
    ///
    /// See [FinanceKit](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.financekit)
    @Entitlement(.financeKit)
    static var financeKit: Bool?
}

// MARK: - Foundation Models

@available(iOS 26.0, macOS 26.0, *)
public extension AppEntitlements {
    /// com.apple.developer.foundation-model-adapter.
    ///
    /// See [com.apple.developer.foundation-model-adapter](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.foundation-model-adapter)
    @Entitlement(.foundationModelAdapter)
    static var foundationModelAdapter: Bool?
}

// MARK: - Games

public extension AppEntitlements {
    /// Game Center Entitlement.
    ///
    /// See [Game Center Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.game-center)
    @Entitlement(.gameCenter)
    static var gameCenter: Bool?
}

// MARK: - Group activities

public extension AppEntitlements {
    /// com.apple.developer.group-session.
    ///
    /// See [com.apple.developer.group-session](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.group-session)
    @Entitlement(.groupSession)
    static var groupSession: Bool?
}

// MARK: - Home automation

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public extension AppEntitlements {
    /// Matter Allow Setup Payload.
    ///
    /// See [Matter Allow Setup Payload](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.matter.allow-setup-payload)
    @Entitlement(.matterAllowSetupPayload)
    static var matterAllowSetupPayload: Bool?
}

// MARK: - Location

public extension AppEntitlements {
    /// Location Push Service Extension.
    ///
    /// See [Location Push Service Extension](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.location.push)
    @Entitlement(.locationPush)
    static var locationPush: Bool?
}

// MARK: - Media

@available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
public extension AppEntitlements {
    /// com.apple.developer.coremotion.head-pose.
    ///
    /// See [com.apple.developer.coremotion.head-pose](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.coremotion.head-pose)
    @Entitlement(.coremotionHeadPose)
    static var coremotionHeadPose: Bool?

    /// com.apple.developer.spatial-audio.profile-access.
    ///
    /// See [com.apple.developer.spatial-audio.profile-access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.spatial-audio.profile-access)
    @Entitlement(.spatialAudioProfileAccess)
    static var spatialAudioProfileAccess: Bool?
}

// MARK: - Metal

@available(iOS 17.0, macOS 15.0, *)
public extension AppEntitlements {
    /// com.apple.developer.sustained-execution.
    ///
    /// See [com.apple.developer.sustained-execution](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.sustained-execution)
    @Entitlement(.sustainedExecution)
    static var sustainedExecution: Bool?
}

// MARK: - Networking

public extension AppEntitlements {
    /// Associated Domains Entitlement.
    ///
    /// See [Associated Domains Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.associated-domains)
    @Entitlement(.associatedDomains)
    static var associatedDomains: [String]?

    /// Personal VPN Entitlement.
    ///
    /// See [Personal VPN Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.vpn.api)
    @Entitlement(.personalVPN)
    static var personalVPN: [String]?
}

@available(iOS 15.0, macOS 12.0, tvOS 17.0, *)
public extension AppEntitlements {
    /// Network Extensions Entitlement.
    ///
    /// See [Network Extensions Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.networkextension)
    @Entitlement(.networkExtensions)
    static var networkExtensions: [String]?
}

// MARK: - Notifications

public extension AppEntitlements {
    /// APS Environment Entitlement.
    ///
    /// See [APS Environment Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/aps-environment)
    @Entitlement(.apsEnvironment)
    static var apsEnvironment: ApsEnvironment?

    /// Critical Alerts.
    ///
    /// See [Critical Alerts](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.usernotifications.critical-alerts)
    @Entitlement(.usernotificationsCriticalAlerts)
    static var usernotificationsCriticalAlerts: Bool?

    /// com.apple.developer.usernotifications.filtering.
    ///
    /// See [com.apple.developer.usernotifications.filtering](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.usernotifications.filtering)
    @Entitlement(.usernotificationsFiltering)
    static var usernotificationsFiltering: Bool?
}

// MARK: - StoreKit

@available(iOS 15.4, macOS 14.4, tvOS 17.4, watchOS 10.4, *)
public extension AppEntitlements {
    /// com.apple.developer.storekit.external-purchase.
    ///
    /// See [com.apple.developer.storekit.external-purchase](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.storekit.external-purchase)
    @Entitlement(.storekitExternalPurchase)
    static var storekitExternalPurchase: Bool?

    /// com.apple.developer.storekit.external-purchase-link.
    ///
    /// See [com.apple.developer.storekit.external-purchase-link](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.storekit.external-purchase-link)
    @Entitlement(.storekitExternalPurchaseLink)
    static var storekitExternalPurchaseLink: Bool?
}

@available(iOS 26.2, macOS 26.2, tvOS 26.2, watchOS 26.2, *)
public extension AppEntitlements {
    /// StoreKit External Custom Purchase Link Regions.
    ///
    /// See [StoreKit External Custom Purchase Link Regions](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.storekit.custom-purchase-link.allowed-regions)
    @Entitlement(.storekitCustomPurchaseLinkAllowedRegions)
    static var storekitCustomPurchaseLinkAllowedRegions: [String]?
}

// MARK: - TV

public extension AppEntitlements {
    /// com.apple.developer.video-subscriber-single-sign-on.
    ///
    /// See [com.apple.developer.video-subscriber-single-sign-on](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.video-subscriber-single-sign-on)
    @Entitlement(.videoSubscriberSingleSignOn)
    static var videoSubscriberSingleSignOn: Bool?

    /// com.apple.smoot.subscriptionservice.
    ///
    /// See [com.apple.smoot.subscriptionservice](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.smoot.subscriptionservice)
    @Entitlement(.smootSubscriptionservice)
    static var smootSubscriptionservice: Bool?
}

// MARK: - WeatherKit

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public extension AppEntitlements {
    /// WeatherKit Entitlement.
    ///
    /// See [WeatherKit Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.weatherkit)
    @Entitlement(.weatherKit)
    static var weatherKit: Bool?
}

// MARK: - iCloud

public extension AppEntitlements {
    /// com.apple.developer.icloud-container-development-container-identifiers.
    ///
    /// See [com.apple.developer.icloud-container-development-container-identifiers](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.icloud-container-development-container-identifiers)
    @Entitlement(.iCloudContainerDevelopmentContainerIdentifiers)
    static var iCloudContainerDevelopmentContainerIdentifiers: [String]?

    /// com.apple.developer.icloud-container-environment.
    ///
    /// See [com.apple.developer.icloud-container-environment](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.icloud-container-environment)
    @Entitlement(.iCloudContainerEnvironment)
    static var iCloudContainerEnvironment: ICloudContainerEnvironment?

    /// iCloud Container Identifiers Entitlement.
    ///
    /// See [iCloud Container Identifiers Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.icloud-container-identifiers)
    @Entitlement(.iCloudContainerIdentifiers)
    static var iCloudContainerIdentifiers: [String]?

    /// iCloud Services Entitlement.
    ///
    /// See [iCloud Services Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.icloud-services)
    @Entitlement(.iCloudServices)
    static var iCloudServices: [String]?

    /// iCloud Key-Value Store Entitlement.
    ///
    /// See [iCloud Key-Value Store Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.ubiquity-kvstore-identifier)
    @Entitlement(.iCloudKeyValueStore)
    static var iCloudKeyValueStore: String?
}
