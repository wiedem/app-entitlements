/// Central registry of all entitlement key identifiers.
public enum Entitlement: String, Sendable {
    // MARK: - Accessibility

    /// Merchant Accessibility API Control.
    ///
    /// See [Merchant Accessibility API Control](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.accessibility.merchant-api-control)
    @available(iOS 18.2, *)
    case accessibilityMerchantApiControl = "com.apple.developer.accessibility.merchant-api-control"

    // MARK: - Accessory Transport Extension

    /// com.apple.developer.accessory-transport-extension.
    ///
    /// See [com.apple.developer.accessory-transport-extension](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.accessory-transport-extension)
    @available(iOS 26.2, *)
    case accessoryTransportExtension = "com.apple.developer.accessory-transport-extension"

    // MARK: - AccessorySetupKit

    /// com.apple.developer.accessory-setup-discovery-extension.
    ///
    /// See [com.apple.developer.accessory-setup-discovery-extension](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.accessory-setup-discovery-extension)
    @available(iOS 18.0, *)
    case accessorySetupDiscoveryExtension = "com.apple.developer.accessory-setup-discovery-extension"

    // MARK: - Alternative app marketplaces

    /// com.apple.developer.marketplace.app-installation.
    ///
    /// See [com.apple.developer.marketplace.app-installation](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.marketplace.app-installation)
    @available(iOS 17.4, *)
    case marketplaceAppInstallation = "com.apple.developer.marketplace.app-installation"

    // MARK: - Alternative browser engines

    /// Embedded Browser Engine Entitlement.
    ///
    /// See [Embedded Browser Engine Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.embedded-web-browser-engine)
    @available(iOS 17.4, *)
    case embeddedWebBrowserEngine = "com.apple.developer.embedded-web-browser-engine"

    /// Embedded Browser Engine Association Entitlement.
    ///
    /// See [Embedded Browser Engine Association Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.embedded-web-browser-engine.engine-association)
    @available(iOS 26.2, *)
    case embeddedWebBrowserEngineEngineAssociation = "com.apple.developer.embedded-web-browser-engine.engine-association"

    /// com.apple.developer.memory.transfer_accept.
    ///
    /// See [com.apple.developer.memory.transfer_accept](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.memory.transfer_accept)
    @available(iOS 17.4, *)
    case memoryTransferAccept = "com.apple.developer.memory.transfer_accept"

    /// com.apple.developer.memory.transfer_send.
    ///
    /// See [com.apple.developer.memory.transfer_send](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.memory.transfer_send)
    @available(iOS 17.4, *)
    case memoryTransferSend = "com.apple.developer.memory.transfer_send"

    /// Web Browser Engine Entitlement.
    ///
    /// See [Web Browser Engine Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser-engine.host)
    @available(iOS 17.4, *)
    case webBrowserEngineHost = "com.apple.developer.web-browser-engine.host"

    /// com.apple.developer.web-browser-engine.networking.
    ///
    /// See [com.apple.developer.web-browser-engine.networking](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser-engine.networking)
    @available(iOS 17.4, *)
    case webBrowserEngineNetworking = "com.apple.developer.web-browser-engine.networking"

    /// com.apple.developer.web-browser-engine.rendering.
    ///
    /// See [com.apple.developer.web-browser-engine.rendering](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser-engine.rendering)
    @available(iOS 17.4, *)
    case webBrowserEngineRendering = "com.apple.developer.web-browser-engine.rendering"

    /// com.apple.developer.web-browser-engine.restrict.notifyd.
    ///
    /// See [com.apple.developer.web-browser-engine.restrict.notifyd](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser-engine.restrict.notifyd)
    @available(iOS 17.4, *)
    case webBrowserEngineRestrictNotifyd = "com.apple.developer.web-browser-engine.restrict.notifyd"

    /// com.apple.developer.web-browser-engine.webcontent.
    ///
    /// See [com.apple.developer.web-browser-engine.webcontent](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser-engine.webcontent)
    @available(iOS 17.4, *)
    case webBrowserEngineWebcontent = "com.apple.developer.web-browser-engine.webcontent"

    // MARK: - App Clips

    /// com.apple.developer.associated-appclip-app-identifiers.
    ///
    /// See [com.apple.developer.associated-appclip-app-identifiers](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.associated-appclip-app-identifiers)
    @available(iOS 15.4, *)
    case associatedAppclipAppIdentifiers = "com.apple.developer.associated-appclip-app-identifiers"

    /// com.apple.developer.on-demand-install-capable.
    ///
    /// See [com.apple.developer.on-demand-install-capable](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.on-demand-install-capable)
    case onDemandInstallCapable = "com.apple.developer.on-demand-install-capable"

    /// Parent Application Identifiers Entitlement.
    ///
    /// See [Parent Application Identifiers Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.parent-application-identifiers)
    case parentApplicationIdentifiers = "com.apple.developer.parent-application-identifiers"

    // MARK: - AppIntents

    /// Side Button Invocation.
    ///
    /// See [Side Button Invocation](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.side-button-access.allow)
    @available(iOS 26.2, *)
    case sideButtonAccessAllow = "com.apple.developer.side-button-access.allow"

    // MARK: - AppMigrationKit

    /// App Identifier for OS Data Transfer.
    ///
    /// See [App Identifier for OS Data Transfer](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.app-migration.data-container-access)
    @available(iOS 26.1, *)
    case appMigrationDataContainerAccess = "com.apple.developer.app-migration.data-container-access"

    // MARK: - Authentication

    /// Account Creation Requires Phone Number.
    ///
    /// See [Account Creation Requires Phone Number](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.authentication-services.account-creation-requires-phone-number)
    @available(iOS 26.0, macOS 26.0, *)
    case authenticationServicesAccountCreationRequiresPhoneNumber = "com.apple.developer.authentication-services.account-creation-requires-phone-number"

    /// AutoFill Credential Provider Entitlement.
    ///
    /// See [AutoFill Credential Provider Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.authentication-services.autofill-credential-provider)
    case autoFillCredentialProvider = "com.apple.developer.authentication-services.autofill-credential-provider"

    /// Sign in with Apple Entitlement.
    ///
    /// See [Sign in with Apple Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.applesignin)
    case signInWithApple = "com.apple.developer.applesignin"

    // MARK: - Background tasks

    /// Background GPU Access.
    ///
    /// See [Background GPU Access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.background-tasks.continued-processing.gpu)
    @available(iOS 26.0, *)
    case backgroundTasksContinuedProcessingGpu = "com.apple.developer.background-tasks.continued-processing.gpu"

    // MARK: - CarPlay

    /// com.apple.developer.carplay-audio.
    ///
    /// See [com.apple.developer.carplay-audio](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carplay-audio)
    case carplayAudio = "com.apple.developer.carplay-audio"

    /// com.apple.developer.carplay-charging.
    ///
    /// See [com.apple.developer.carplay-charging](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carplay-charging)
    case carplayCharging = "com.apple.developer.carplay-charging"

    /// com.apple.developer.carplay-communication.
    ///
    /// See [com.apple.developer.carplay-communication](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carplay-communication)
    case carplayCommunication = "com.apple.developer.carplay-communication"

    /// com.apple.developer.carplay-maps.
    ///
    /// See [com.apple.developer.carplay-maps](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carplay-maps)
    case carplayMaps = "com.apple.developer.carplay-maps"

    /// com.apple.developer.carplay-messaging.
    ///
    /// See [com.apple.developer.carplay-messaging](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carplay-messaging)
    case carplayMessaging = "com.apple.developer.carplay-messaging"

    /// com.apple.developer.carplay-parking.
    ///
    /// See [com.apple.developer.carplay-parking](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carplay-parking)
    case carplayParking = "com.apple.developer.carplay-parking"

    /// com.apple.developer.carplay-quick-ordering.
    ///
    /// See [com.apple.developer.carplay-quick-ordering](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carplay-quick-ordering)
    case carplayQuickOrdering = "com.apple.developer.carplay-quick-ordering"

    /// com.apple.developer.playable-content.
    ///
    /// See [com.apple.developer.playable-content](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.playable-content)
    case playableContent = "com.apple.developer.playable-content"

    // MARK: - CloudKit

    /// com.apple.developer.icloud-extended-share-access.
    ///
    /// See [com.apple.developer.icloud-extended-share-access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.icloud-extended-share-access)
    @available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *)
    case iCloudExtendedShareAccess = "com.apple.developer.icloud-extended-share-access"

    // MARK: - Contacts

    /// com.apple.developer.contacts.notes.
    ///
    /// See [com.apple.developer.contacts.notes](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.contacts.notes)
    @available(iOS 15.0, macOS 13.0, *)
    case contactsNotes = "com.apple.developer.contacts.notes"

    // MARK: - CoreTelephony

    /// com.apple.CommCenter.fine-grained.
    ///
    /// See [com.apple.CommCenter.fine-grained](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.commcenter.fine-grained)
    case commCenterFineGrained = "com.apple.CommCenter.fine-grained"

    // MARK: - Declared Age Range

    /// com.apple.developer.declared-age-range.
    ///
    /// See [com.apple.developer.declared-age-range](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.declared-age-range)
    @available(iOS 26.0, macOS 26.0, *)
    case declaredAgeRange = "com.apple.developer.declared-age-range"

    // MARK: - Deprecated entitlements

    /// All Files Entitlement.
    ///
    /// See [All Files Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.security.files.all)
    case allFiles = "com.apple.security.files.all"

    /// Inter-App Audio Entitlement.
    ///
    /// See [Inter-App Audio Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/inter-app-audio)
    case interAppAudio = "inter-app-audio"

    /// Maps Entitlement.
    ///
    /// See [Maps Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.maps)
    case maps = "com.apple.developer.maps"

    // MARK: - Device Management

    /// com.apple.developer.automated-device-enrollment.add-devices.
    ///
    /// See [com.apple.developer.automated-device-enrollment.add-devices](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.automated-device-enrollment.add-devices)
    @available(iOS 16.0, *)
    case automatedDeviceEnrollmentAddDevices = "com.apple.developer.automated-device-enrollment.add-devices"

    /// Enrollment Single Sign On.
    ///
    /// See [Enrollment Single Sign On](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.enrollment-sso-capable)
    case enrollmentSsoCapable = "com.apple.developer.enrollment-sso-capable"

    // MARK: - Education

    /// com.apple.developer.automatic-assessment-configuration.
    ///
    /// See [com.apple.developer.automatic-assessment-configuration](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.automatic-assessment-configuration)
    case automaticAssessmentConfiguration = "com.apple.developer.automatic-assessment-configuration"

    /// ClassKit Environment Entitlement.
    ///
    /// See [ClassKit Environment Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.classkit-environment)
    case classKitEnvironment = "com.apple.developer.ClassKit-environment"

    // MARK: - Email clients

    /// com.apple.developer.mail-client.
    ///
    /// See [com.apple.developer.mail-client](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.mail-client)
    case mailClient = "com.apple.developer.mail-client"

    // MARK: - EnergyKit

    /// com.apple.developer.energykit.
    ///
    /// See [com.apple.developer.energykit](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.energykit)
    @available(iOS 26.0, *)
    case energykit = "com.apple.developer.energykit"

    // MARK: - Enterprise

    /// Increased performance headroom.
    ///
    /// See [Increased performance headroom](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.app-compute-category)
    case appComputeCategory = "com.apple.developer.app-compute-category"

    /// Spatial barcode and QR code scanning.
    ///
    /// See [Spatial barcode and QR code scanning](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.arkit.barcode-detection.allow)
    case arkitBarcodeDetectionAllow = "com.apple.developer.arkit.barcode-detection.allow"

    /// Camera Region access.
    ///
    /// See [Camera Region access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.arkit.camera-region.allow)
    case arkitCameraRegionAllow = "com.apple.developer.arkit.camera-region.allow"

    /// Main camera access.
    ///
    /// See [Main camera access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.arkit.main-camera-access.allow)
    case arkitMainCameraAccessAllow = "com.apple.developer.arkit.main-camera-access.allow"

    /// Object-tracking parameter adjustment.
    ///
    /// See [Object-tracking parameter adjustment](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.arkit.object-tracking-parameter-adjustment.allow)
    case arkitObjectTrackingParameterAdjustmentAllow = "com.apple.developer.arkit.object-tracking-parameter-adjustment.allow"

    /// Shared Coordinated Space access.
    ///
    /// See [Shared Coordinated Space access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.arkit.shared-coordinate-space.allow)
    case arkitSharedCoordinateSpaceAllow = "com.apple.developer.arkit.shared-coordinate-space.allow"

    /// UVC Device Access on visionOS.
    ///
    /// See [UVC Device Access on visionOS](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.avfoundation.uvc-device-access)
    case avfoundationUvcDeviceAccess = "com.apple.developer.avfoundation.uvc-device-access"

    /// Apple Neural Engine access.
    ///
    /// See [Apple Neural Engine access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.coreml.neural-engine-access)
    case coremlNeuralEngineAccess = "com.apple.developer.coreml.neural-engine-access"

    /// App-Protected Content.
    ///
    /// See [App-Protected Content](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.protected-content)
    case protectedContent = "com.apple.developer.protected-content"

    /// Passthrough in screen capture.
    ///
    /// See [Passthrough in screen capture](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.screen-capture.include-passthrough)
    case screenCaptureIncludePassthrough = "com.apple.developer.screen-capture.include-passthrough"

    /// Follow Mode for Windows.
    ///
    /// See [Follow Mode for Windows](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.window-body-follow)
    case windowBodyFollow = "com.apple.developer.window-body-follow"

    // MARK: - Exposure notification

    /// com.apple.developer.exposure-notification.
    ///
    /// See [com.apple.developer.exposure-notification](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.exposure-notification)
    case exposureNotification = "com.apple.developer.exposure-notification"

    // MARK: - FSKit

    /// FSKit Module.
    ///
    /// See [FSKit Module](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.fskit.fsmodule)
    @available(macOS 15.4, *)
    case fskitFsmodule = "com.apple.developer.fskit.fsmodule"

    // MARK: - Family controls

    /// Family Controls.
    ///
    /// See [Family Controls](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.family-controls)
    case familyControls = "com.apple.developer.family-controls"

    // MARK: - File provider

    /// com.apple.developer.fileprovider.testing-mode.
    ///
    /// See [com.apple.developer.fileprovider.testing-mode](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.fileprovider.testing-mode)
    case fileproviderTestingMode = "com.apple.developer.fileprovider.testing-mode"

    // MARK: - FinanceKit

    /// FinanceKit.
    ///
    /// See [FinanceKit](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.financekit)
    case financeKit = "com.apple.developer.financekit"

    // MARK: - Foundation Models

    /// com.apple.developer.foundation-model-adapter.
    ///
    /// See [com.apple.developer.foundation-model-adapter](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.foundation-model-adapter)
    @available(iOS 26.0, macOS 26.0, *)
    case foundationModelAdapter = "com.apple.developer.foundation-model-adapter"

    // MARK: - Games

    /// Game Center Entitlement.
    ///
    /// See [Game Center Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.game-center)
    case gameCenter = "com.apple.developer.game-center"

    // MARK: - Group activities

    /// com.apple.developer.group-session.
    ///
    /// See [com.apple.developer.group-session](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.group-session)
    case groupSession = "com.apple.developer.group-session"

    // MARK: - Health

    /// Fall Detection Notifications.
    ///
    /// See [Fall Detection Notifications](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.health.fall-detection)
    case healthFallDetection = "com.apple.developer.health.fall-detection"

    /// HealthKit Entitlement.
    ///
    /// See [HealthKit Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.healthkit)
    case healthKit = "com.apple.developer.healthkit"

    /// com.apple.developer.healthkit.background-delivery.
    ///
    /// See [com.apple.developer.healthkit.background-delivery](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.healthkit.background-delivery)
    case healthKitBackgroundDelivery = "com.apple.developer.healthkit.background-delivery"

    /// HealthKit Capabilities Entitlement.
    ///
    /// See [HealthKit Capabilities Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.healthkit.access)
    case healthKitCapabilities = "com.apple.developer.healthkit.access"

    /// com.apple.developer.healthkit.recalibrate-estimates.
    ///
    /// See [com.apple.developer.healthkit.recalibrate-estimates](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.healthkit.recalibrate-estimates)
    case healthKitRecalibrateEstimates = "com.apple.developer.healthkit.recalibrate-estimates"

    // MARK: - Home automation

    /// HomeKit Entitlement.
    ///
    /// See [HomeKit Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.homekit)
    case homeKit = "com.apple.developer.homekit"

    /// Matter Allow Setup Payload.
    ///
    /// See [Matter Allow Setup Payload](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.matter.allow-setup-payload)
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    case matterAllowSetupPayload = "com.apple.developer.matter.allow-setup-payload"

    // MARK: - Hypervisor

    /// com.apple.security.hypervisor.
    ///
    /// See [com.apple.security.hypervisor](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.security.hypervisor)
    case hypervisor = "com.apple.security.hypervisor"

    /// com.apple.security.virtualization.
    ///
    /// See [com.apple.security.virtualization](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.security.virtualization)
    case virtualization = "com.apple.security.virtualization"

    /// com.apple.vm.device-access.
    ///
    /// See [com.apple.vm.device-access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.vm.device-access)
    case vmDeviceAccess = "com.apple.vm.device-access"

    /// com.apple.vm.hypervisor.
    ///
    /// See [com.apple.vm.hypervisor](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.vm.hypervisor)
    case vmHypervisor = "com.apple.vm.hypervisor"

    /// com.apple.vm.networking.
    ///
    /// See [com.apple.vm.networking](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.vm.networking)
    case vmNetworking = "com.apple.vm.networking"

    // MARK: - IdentityDocumentServices

    /// Digital Credentials API - Mobile Document Provider.
    ///
    /// See [Digital Credentials API - Mobile Document Provider](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.identity-document-services.document-provider.mobile-document-types)
    @available(iOS 26.0, *)
    case identityDocumentServicesDocumentProviderMobileDocumentTypes = "com.apple.developer.identity-document-services.document-provider.mobile-document-types"

    // MARK: - Journaling Suggestions

    /// com.apple.developer.journal.allow.
    ///
    /// See [com.apple.developer.journal.allow](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.journal.allow)
    @available(iOS 17.2, *)
    case journalAllow = "com.apple.developer.journal.allow"

    // MARK: - LiveCommunicationKit

    /// Default Calling App.
    ///
    /// See [Default Calling App](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.calling-app)
    @available(iOS 18.2, watchOS 11.2, *)
    case callingApp = "com.apple.developer.calling-app"

    /// Default Dialer App.
    ///
    /// See [Default Dialer App](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.dialing-app)
    @available(iOS 26.0, *)
    case dialingApp = "com.apple.developer.dialing-app"

    // MARK: - Location

    /// Location Push Service Extension.
    ///
    /// See [Location Push Service Extension](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.location.push)
    case locationPush = "com.apple.developer.location.push"

    // MARK: - Managed App Distribution

    /// Managed App Installation UI.
    ///
    /// See [Managed App Installation UI](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.managed-app-distribution.install-ui)
    @available(iOS 17.2, *)
    case managedAppDistributionInstallUi = "com.apple.developer.managed-app-distribution.install-ui"

    // MARK: - Media

    /// com.apple.developer.avfoundation.multitasking-camera-access.
    ///
    /// See [com.apple.developer.avfoundation.multitasking-camera-access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.avfoundation.multitasking-camera-access)
    @available(iOS, introduced: 15.0, deprecated: 18.0)
    case avfoundationMultitaskingCameraAccess = "com.apple.developer.avfoundation.multitasking-camera-access"

    /// com.apple.developer.coremotion.head-pose.
    ///
    /// See [com.apple.developer.coremotion.head-pose](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.coremotion.head-pose)
    @available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
    case coremotionHeadPose = "com.apple.developer.coremotion.head-pose"

    /// Media Device Discovery Extension.
    ///
    /// See [Media Device Discovery Extension](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.media-device-discovery-extension)
    @available(iOS 16.0, *)
    case mediaDeviceDiscoveryExtension = "com.apple.developer.media-device-discovery-extension"

    /// com.apple.developer.spatial-audio.profile-access.
    ///
    /// See [com.apple.developer.spatial-audio.profile-access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.spatial-audio.profile-access)
    @available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
    case spatialAudioProfileAccess = "com.apple.developer.spatial-audio.profile-access"

    // MARK: - Memory

    /// Extended Virtual Addressing Entitlement.
    ///
    /// See [Extended Virtual Addressing Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.kernel.extended-virtual-addressing)
    case kernelExtendedVirtualAddressing = "com.apple.developer.kernel.extended-virtual-addressing"

    /// com.apple.developer.kernel.increased-memory-limit.
    ///
    /// See [com.apple.developer.kernel.increased-memory-limit](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.kernel.increased-memory-limit)
    case kernelIncreasedMemoryLimit = "com.apple.developer.kernel.increased-memory-limit"

    // MARK: - MessageUI

    /// com.apple.developer.upi-device-validation.
    ///
    /// See [com.apple.developer.upi-device-validation](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.upi-device-validation)
    @available(iOS 17.0, *)
    case upiDeviceValidation = "com.apple.developer.upi-device-validation"

    // MARK: - Messages

    /// Critical Messaging.
    ///
    /// See [Critical Messaging](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.messages.critical-messaging)
    @available(iOS 18.2, watchOS 11.2, *)
    case messagesCriticalMessaging = "com.apple.developer.messages.critical-messaging"

    /// Default Messaging App.
    ///
    /// See [Default Messaging App](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.messaging-app)
    @available(iOS 18.2, *)
    case messagingApp = "com.apple.developer.messaging-app"

    // MARK: - Metal

    /// com.apple.developer.sustained-execution.
    ///
    /// See [com.apple.developer.sustained-execution](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.sustained-execution)
    @available(iOS 17.0, macOS 15.0, *)
    case sustainedExecution = "com.apple.developer.sustained-execution"

    // MARK: - Navigation

    /// Default Navigation.
    ///
    /// See [Default Navigation](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.navigation-app)
    @available(iOS 18.4, *)
    case navigationApp = "com.apple.developer.navigation-app"

    // MARK: - NearbyInteraction

    /// Nearby Interaction NI DL-TDOA API (development).
    ///
    /// See [Nearby Interaction NI DL-TDOA API (development)](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nearbyinteraction.dltdoa)
    @available(iOS 26.1, *)
    case nearbyinteractionDltdoa = "com.apple.developer.nearbyinteraction.dltdoa"

    // MARK: - Networking

    /// Associated Domains Entitlement.
    ///
    /// See [Associated Domains Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.associated-domains)
    case associatedDomains = "com.apple.developer.associated-domains"

    /// com.apple.developer.associated-domains.applinks.read-write.
    ///
    /// See [com.apple.developer.associated-domains.applinks.read-write](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.associated-domains.applinks.read-write)
    case associatedDomainsApplinksReadWrite = "com.apple.developer.associated-domains.applinks.read-write"

    /// Network Extensions Entitlement.
    ///
    /// See [Network Extensions Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.networkextension)
    @available(iOS 15.0, macOS 12.0, tvOS 17.0, *)
    case networkExtensions = "com.apple.developer.networking.networkextension"

    /// com.apple.developer.networking.carrier-constrained.app-optimized.
    ///
    /// See [com.apple.developer.networking.carrier-constrained.app-optimized](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.carrier-constrained.app-optimized)
    @available(iOS 26.0, *)
    case networkingCarrierConstrainedAppOptimized = "com.apple.developer.networking.carrier-constrained.app-optimized"

    /// com.apple.developer.networking.carrier-constrained.appcategory.
    ///
    /// See [com.apple.developer.networking.carrier-constrained.appcategory](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.carrier-constrained.appcategory)
    @available(iOS 26.0, *)
    case networkingCarrierConstrainedAppcategory = "com.apple.developer.networking.carrier-constrained.appcategory"

    /// com.apple.developer.networking.manage-thread-network-credentials.
    ///
    /// See [com.apple.developer.networking.manage-thread-network-credentials](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.manage-thread-network-credentials)
    case networkingManageThreadNetworkCredentials = "com.apple.developer.networking.manage-thread-network-credentials"

    /// com.apple.developer.networking.multicast.
    ///
    /// See [com.apple.developer.networking.multicast](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.multicast)
    case networkingMulticast = "com.apple.developer.networking.multicast"

    /// 5G Network Slicing App Category.
    ///
    /// See [5G Network Slicing App Category](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.slicing.appcategory)
    @available(iOS 17.0, *)
    case networkingSlicingAppcategory = "com.apple.developer.networking.slicing.appcategory"

    /// 5G Network Slicing Traffic Category.
    ///
    /// See [5G Network Slicing Traffic Category](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.slicing.trafficcategory)
    @available(iOS 17.0, *)
    case networkingSlicingTrafficcategory = "com.apple.developer.networking.slicing.trafficcategory"

    /// com.apple.developer.networking.vmnet.
    ///
    /// See [com.apple.developer.networking.vmnet](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.vmnet)
    @available(macOS 14.0, *)
    case networkingVmnet = "com.apple.developer.networking.vmnet"

    /// Personal VPN Entitlement.
    ///
    /// See [Personal VPN Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.vpn.api)
    case personalVPN = "com.apple.developer.networking.vpn.api"

    // MARK: - Notifications

#if os(macOS)
    /// APS Environment (macOS) Entitlement.
    ///
    /// See [APS Environment (macOS) Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.aps-environment)
    case apsEnvironment = "com.apple.developer.aps-environment"
#else
    /// APS Environment Entitlement.
    ///
    /// See [APS Environment Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/aps-environment)
    case apsEnvironment = "aps-environment"
#endif

    /// Critical Alerts.
    ///
    /// See [Critical Alerts](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.usernotifications.critical-alerts)
    case usernotificationsCriticalAlerts = "com.apple.developer.usernotifications.critical-alerts"

    /// com.apple.developer.usernotifications.filtering.
    ///
    /// See [com.apple.developer.usernotifications.filtering](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.usernotifications.filtering)
    case usernotificationsFiltering = "com.apple.developer.usernotifications.filtering"

    // MARK: - PassKit

    /// Pass Presentation Suppression.
    ///
    /// See [Pass Presentation Suppression](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.passkit.pass-presentation-suppression)
    case passkitPassPresentationSuppression = "com.apple.developer.passkit.pass-presentation-suppression"

    // MARK: - Privacy

    /// com.apple.developer.device-information.user-assigned-device-name.
    ///
    /// See [com.apple.developer.device-information.user-assigned-device-name](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.device-information.user-assigned-device-name)
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
    case deviceInformationUserAssignedDeviceName = "com.apple.developer.device-information.user-assigned-device-name"

    // MARK: - Push to Talk

    /// Push to Talk Entitlement.
    ///
    /// See [Push to Talk Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.push-to-talk)
    @available(iOS 16.0, *)
    case pushToTalk = "com.apple.developer.push-to-talk"

    // MARK: - SafetyKit

    /// com.apple.developer.severe-vehicular-crash-event.
    ///
    /// See [com.apple.developer.severe-vehicular-crash-event](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.severe-vehicular-crash-event)
    @available(iOS 16.0, watchOS 10.1, *)
    case severeVehicularCrashEvent = "com.apple.developer.severe-vehicular-crash-event"

    // MARK: - ScreenCaptureKit

    /// Persistent Content Capture.
    ///
    /// See [Persistent Content Capture](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.persistent-content-capture)
    @available(macOS 14.4, *)
    case persistentContentCapture = "com.apple.developer.persistent-content-capture"

    // MARK: - SecureElementCredential

    /// com.apple.developer.secure-element-credential.
    ///
    /// See [com.apple.developer.secure-element-credential](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.secure-element-credential)
    @available(iOS 18.1, *)
    case secureElementCredential = "com.apple.developer.secure-element-credential"

    /// com.apple.developer.secure-element-credential.default-contactless-app.
    ///
    /// See [com.apple.developer.secure-element-credential.default-contactless-app](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.secure-element-credential.default-contactless-app)
    @available(iOS 18.1, *)
    case secureElementCredentialDefaultContactlessApp = "com.apple.developer.secure-element-credential.default-contactless-app"

    // MARK: - Sensitive Content Analysis

    /// com.apple.developer.sensitivecontentanalysis.client.
    ///
    /// See [com.apple.developer.sensitivecontentanalysis.client](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.sensitivecontentanalysis.client)
    @available(iOS 17.0, *)
    case sensitivecontentanalysisClient = "com.apple.developer.sensitivecontentanalysis.client"

    // MARK: - Sensors

    /// com.apple.developer.sensorkit.reader.allow.
    ///
    /// See [com.apple.developer.sensorkit.reader.allow](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.sensorkit.reader.allow)
    case sensorkitReaderAllow = "com.apple.developer.sensorkit.reader.allow"

    // MARK: - Siri

    /// Siri Entitlement.
    ///
    /// See [Siri Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.siri)
    case siri = "com.apple.developer.siri"

    // MARK: - StoreKit

    /// StoreKit External Custom Purchase Link Regions.
    ///
    /// See [StoreKit External Custom Purchase Link Regions](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.storekit.custom-purchase-link.allowed-regions)
    @available(iOS 26.2, macOS 26.2, tvOS 26.2, watchOS 26.2, *)
    case storekitCustomPurchaseLinkAllowedRegions = "com.apple.developer.storekit.custom-purchase-link.allowed-regions"

    /// com.apple.developer.storekit.external-link.account.
    ///
    /// See [com.apple.developer.storekit.external-link.account](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.storekit.external-link.account)
    @available(iOS 15.4, tvOS 16.4, *)
    case storekitExternalLinkAccount = "com.apple.developer.storekit.external-link.account"

    /// com.apple.developer.storekit.external-purchase.
    ///
    /// See [com.apple.developer.storekit.external-purchase](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.storekit.external-purchase)
    @available(iOS 15.4, macOS 14.4, tvOS 17.4, watchOS 10.4, *)
    case storekitExternalPurchase = "com.apple.developer.storekit.external-purchase"

    /// com.apple.developer.storekit.external-purchase-link.
    ///
    /// See [com.apple.developer.storekit.external-purchase-link](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.storekit.external-purchase-link)
    @available(iOS 15.4, macOS 14.4, tvOS 17.4, watchOS 10.4, *)
    case storekitExternalPurchaseLink = "com.apple.developer.storekit.external-purchase-link"

    /// com.apple.developer.storekit.external-purchase-link-streaming.
    ///
    /// See [com.apple.developer.storekit.external-purchase-link-streaming](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.storekit.external-purchase-link-streaming)
    @available(iOS 18.2, *)
    case storekitExternalPurchaseLinkStreaming = "com.apple.developer.storekit.external-purchase-link-streaming"

    // MARK: - TV

    /// com.apple.smoot.subscriptionservice.
    ///
    /// See [com.apple.smoot.subscriptionservice](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.smoot.subscriptionservice)
    case smootSubscriptionservice = "com.apple.smoot.subscriptionservice"

    /// User Management Entitlement.
    ///
    /// See [User Management Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.user-management)
    case userManagement = "com.apple.developer.user-management"

    /// com.apple.developer.video-subscriber-single-sign-on.
    ///
    /// See [com.apple.developer.video-subscriber-single-sign-on](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.video-subscriber-single-sign-on)
    case videoSubscriberSingleSignOn = "com.apple.developer.video-subscriber-single-sign-on"

    // MARK: - TelephonyMessagingKit

    /// Default Carrier Messaging App.
    ///
    /// See [Default Carrier Messaging App](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carrier-messaging-app)
    @available(iOS 26.0, *)
    case carrierMessagingApp = "com.apple.developer.carrier-messaging-app"

    // MARK: - Translation

    /// Translation.
    ///
    /// See [Translation](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.translation-app)
    @available(iOS 18.4, *)
    case translationApp = "com.apple.developer.translation-app"

    // MARK: - Vision

    /// com.apple.developer.foveated-streaming-session.
    ///
    /// See [com.apple.developer.foveated-streaming-session](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.foveated-streaming-session)
    case foveatedStreamingSession = "com.apple.developer.foveated-streaming-session"

    /// Low-Latency Streaming.
    ///
    /// See [Low-Latency Streaming](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.low-latency-streaming)
    case lowLatencyStreaming = "com.apple.developer.low-latency-streaming"

    // MARK: - Wallet

    /// com.apple.developer.in-app-identity-presentment.
    ///
    /// See [com.apple.developer.in-app-identity-presentment](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.in-app-identity-presentment)
    @available(iOS 16.0, *)
    case inAppIdentityPresentment = "com.apple.developer.in-app-identity-presentment"

    /// com.apple.developer.in-app-identity-presentment.merchant-identifiers.
    ///
    /// See [com.apple.developer.in-app-identity-presentment.merchant-identifiers](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.in-app-identity-presentment.merchant-identifiers)
    @available(iOS 16.0, *)
    case inAppIdentityPresentmentMerchantIdentifiers = "com.apple.developer.in-app-identity-presentment.merchant-identifiers"

    /// Merchant IDs Entitlement.
    ///
    /// See [Merchant IDs Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.in-app-payments)
    case merchantIdentifiers = "com.apple.developer.in-app-payments"

    /// Pass Type IDs Entitlement.
    ///
    /// See [Pass Type IDs Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.pass-type-identifiers)
    case passTypeIdentifiers = "com.apple.developer.pass-type-identifiers"

    /// ID Verifier - Display Only.
    ///
    /// See [ID Verifier - Display Only](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.proximity-reader.identity.display)
    @available(iOS 17.0, *)
    case proximityReaderIdentityDisplay = "com.apple.developer.proximity-reader.identity.display"

    /// ID Verifier - Data Transfer.
    ///
    /// See [ID Verifier - Data Transfer](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.proximity-reader.identity.read)
    @available(iOS 17.0, *)
    case proximityReaderIdentityRead = "com.apple.developer.proximity-reader.identity.read"

    // MARK: - WeatherKit

    /// WeatherKit Entitlement.
    ///
    /// See [WeatherKit Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.weatherkit)
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    case weatherKit = "com.apple.developer.weatherkit"

    // MARK: - Web browsers

    /// com.apple.developer.browser.app-installation.
    ///
    /// See [com.apple.developer.browser.app-installation](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.browser.app-installation)
    @available(iOS 17.4, *)
    case browserAppInstallation = "com.apple.developer.browser.app-installation"

    /// com.apple.developer.web-browser.
    ///
    /// See [com.apple.developer.web-browser](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser)
    case webBrowser = "com.apple.developer.web-browser"

    /// com.apple.developer.web-browser.public-key-credential.
    ///
    /// See [com.apple.developer.web-browser.public-key-credential](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser.public-key-credential)
    @available(macOS 13.3, *)
    case webBrowserPublicKeyCredential = "com.apple.developer.web-browser.public-key-credential"

    // MARK: - Wi-Fi Aware

    /// com.apple.developer.wifi-aware.
    ///
    /// See [com.apple.developer.wifi-aware](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.wifi-aware)
    @available(iOS 26.0, *)
    case wifiAware = "com.apple.developer.wifi-aware"

    // MARK: - Wi-Fi Infrastructure

    /// com.apple.developer.wifi-infrastructure.
    ///
    /// See [com.apple.developer.wifi-infrastructure](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.wifi-infrastructure)
    @available(iOS 26.2, *)
    case wifiInfrastructure = "com.apple.developer.wifi-infrastructure"

    // MARK: - Wireless insights

    /// Wireless Insights Service Predictions.
    ///
    /// See [Wireless Insights Service Predictions](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.wireless-insights.service-predictions)
    @available(iOS 26.0, *)
    case wirelessInsightsServicePredictions = "com.apple.developer.wireless-insights.service-predictions"

    // MARK: - Wireless interfaces

    /// Access Wi-Fi Information Entitlement.
    ///
    /// See [Access Wi-Fi Information Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.wifi-info)
    case accessWiFiInformation = "com.apple.developer.networking.wifi-info"

    /// Hotspot Configuration Entitlement.
    ///
    /// See [Hotspot Configuration Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.hotspotconfiguration)
    case hotspotConfiguration = "com.apple.developer.networking.HotspotConfiguration"

    /// Multipath Entitlement.
    ///
    /// See [Multipath Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.multipath)
    case multipath = "com.apple.developer.networking.multipath"

    /// Near Field Communication Tag Reader Session Formats Entitlement.
    ///
    /// See [Near Field Communication Tag Reader Session Formats Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nfc.readersession.formats)
    case nearFieldCommunicationTagReaderSessionFormats = "com.apple.developer.nfc.readersession.formats"

    /// HotSpot Helper.
    ///
    /// See [HotSpot Helper](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.hotspothelper)
    case networkingHotspotHelper = "com.apple.developer.networking.HotspotHelper"

    /// com.apple.developer.nfc.hce.
    ///
    /// See [com.apple.developer.nfc.hce](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nfc.hce)
    @available(iOS 17.4, *)
    case nfcHce = "com.apple.developer.nfc.hce"

    /// com.apple.developer.nfc.hce.default-contactless-app.
    ///
    /// See [com.apple.developer.nfc.hce.default-contactless-app](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nfc.hce.default-contactless-app)
    @available(iOS 17.4, *)
    case nfcHceDefaultContactlessApp = "com.apple.developer.nfc.hce.default-contactless-app"

    /// com.apple.developer.nfc.hce.iso7816.select-identifier-prefixes.
    ///
    /// See [com.apple.developer.nfc.hce.iso7816.select-identifier-prefixes](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nfc.hce.iso7816.select-identifier-prefixes)
    @available(iOS 17.4, *)
    case nfcHceIsoSelectIdentifierPrefixes = "com.apple.developer.nfc.hce.iso7816.select-identifier-prefixes"

    /// ISO18092 system codes for NFC Tag Reader Session.
    ///
    /// See [ISO18092 system codes for NFC Tag Reader Session](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nfc.readersession.felica.systemcodes)
    case nfcReadersessionFelicaSystemcodes = "com.apple.developer.nfc.readersession.felica.systemcodes"

    /// ISO7816 application identifiers for NFC Tag Reader Session.
    ///
    /// See [ISO7816 application identifiers for NFC Tag Reader Session](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nfc.readersession.iso7816.select-identifiers)
    case nfcReadersessionIsoSelectIdentifiers = "com.apple.developer.nfc.readersession.iso7816.select-identifiers"

    /// Wireless Accessory Configuration Entitlement.
    ///
    /// See [Wireless Accessory Configuration Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.external-accessory.wireless-configuration)
    case wirelessAccessoryConfiguration = "com.apple.external-accessory.wireless-configuration"

    // MARK: - iCloud

    /// com.apple.developer.icloud-container-development-container-identifiers.
    ///
    /// See [com.apple.developer.icloud-container-development-container-identifiers](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.icloud-container-development-container-identifiers)
    case iCloudContainerDevelopmentContainerIdentifiers = "com.apple.developer.icloud-container-development-container-identifiers"

    /// com.apple.developer.icloud-container-environment.
    ///
    /// See [com.apple.developer.icloud-container-environment](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.icloud-container-environment)
    case iCloudContainerEnvironment = "com.apple.developer.icloud-container-environment"

    /// iCloud Container Identifiers Entitlement.
    ///
    /// See [iCloud Container Identifiers Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.icloud-container-identifiers)
    case iCloudContainerIdentifiers = "com.apple.developer.icloud-container-identifiers"

    /// iCloud Key-Value Store Entitlement.
    ///
    /// See [iCloud Key-Value Store Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.ubiquity-kvstore-identifier)
    case iCloudKeyValueStore = "com.apple.developer.ubiquity-kvstore-identifier"

    /// iCloud Services Entitlement.
    ///
    /// See [iCloud Services Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.icloud-services)
    case iCloudServices = "com.apple.developer.icloud-services"
    /// Data Protection Entitlement.
    ///
    /// See [Data Protection Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.default-data-protection)
    case defaultDataProtection = "com.apple.developer.default-data-protection"

    /// App Attest Environment.
    ///
    /// See [App Attest Environment](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.devicecheck.appattest-environment)
    case deviceCheckAppAttestEnvironment = "com.apple.developer.devicecheck.appattest-environment"
}
