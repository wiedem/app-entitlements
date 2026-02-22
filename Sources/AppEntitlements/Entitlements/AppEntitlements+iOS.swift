internal import AppEntitlementsCore
internal import AppEntitlementsMacros
public import Foundation

// MARK: - Accessibility

@available(iOS 18.2, *)
public extension AppEntitlements {
    /// Merchant Accessibility API Control.
    ///
    /// See [Merchant Accessibility API Control](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.accessibility.merchant-api-control)
    @Entitlement(.accessibilityMerchantApiControl)
    static var accessibilityMerchantApiControl: Bool?
}

// MARK: - Accessory Transport Extension

@available(iOS 26.2, *)
public extension AppEntitlements {
    /// com.apple.developer.accessory-transport-extension.
    ///
    /// See [com.apple.developer.accessory-transport-extension](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.accessory-transport-extension)
    @Entitlement(.accessoryTransportExtension)
    static var accessoryTransportExtension: Bool?
}

// MARK: - AccessorySetupKit

@available(iOS 18.0, *)
public extension AppEntitlements {
    /// com.apple.developer.accessory-setup-discovery-extension.
    ///
    /// See [com.apple.developer.accessory-setup-discovery-extension](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.accessory-setup-discovery-extension)
    @Entitlement(.accessorySetupDiscoveryExtension)
    static var accessorySetupDiscoveryExtension: Bool?
}

// MARK: - Alternative app marketplaces

@available(iOS 17.4, *)
public extension AppEntitlements {
    /// com.apple.developer.marketplace.app-installation.
    ///
    /// See [com.apple.developer.marketplace.app-installation](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.marketplace.app-installation)
    @Entitlement(.marketplaceAppInstallation)
    static var marketplaceAppInstallation: Bool?
}

// MARK: - Alternative browser engines

@available(iOS 17.4, *)
public extension AppEntitlements {
    /// Embedded Browser Engine Entitlement.
    ///
    /// See [Embedded Browser Engine Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.embedded-web-browser-engine)
    @Entitlement(.embeddedWebBrowserEngine)
    static var embeddedWebBrowserEngine: Bool?

    /// com.apple.developer.memory.transfer_accept.
    ///
    /// See [com.apple.developer.memory.transfer_accept](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.memory.transfer_accept)
    @Entitlement(.memoryTransferAccept)
    static var memoryTransferAccept: String?

    /// com.apple.developer.memory.transfer_send.
    ///
    /// See [com.apple.developer.memory.transfer_send](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.memory.transfer_send)
    @Entitlement(.memoryTransferSend)
    static var memoryTransferSend: String?

    /// Web Browser Engine Entitlement.
    ///
    /// See [Web Browser Engine Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser-engine.host)
    @Entitlement(.webBrowserEngineHost)
    static var webBrowserEngineHost: Bool?

    /// com.apple.developer.web-browser-engine.networking.
    ///
    /// See [com.apple.developer.web-browser-engine.networking](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser-engine.networking)
    @Entitlement(.webBrowserEngineNetworking)
    static var webBrowserEngineNetworking: Bool?

    /// com.apple.developer.web-browser-engine.rendering.
    ///
    /// See [com.apple.developer.web-browser-engine.rendering](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser-engine.rendering)
    @Entitlement(.webBrowserEngineRendering)
    static var webBrowserEngineRendering: Bool?

    /// com.apple.developer.web-browser-engine.restrict.notifyd.
    ///
    /// See [com.apple.developer.web-browser-engine.restrict.notifyd](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser-engine.restrict.notifyd)
    @Entitlement(.webBrowserEngineRestrictNotifyd)
    static var webBrowserEngineRestrictNotifyd: Bool?

    /// com.apple.developer.web-browser-engine.webcontent.
    ///
    /// See [com.apple.developer.web-browser-engine.webcontent](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser-engine.webcontent)
    @Entitlement(.webBrowserEngineWebcontent)
    static var webBrowserEngineWebcontent: Bool?
}

@available(iOS 26.2, *)
public extension AppEntitlements {
    /// Embedded Browser Engine Association Entitlement.
    ///
    /// See [Embedded Browser Engine Association Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.embedded-web-browser-engine.engine-association)
    @Entitlement(.embeddedWebBrowserEngineEngineAssociation)
    static var embeddedWebBrowserEngineEngineAssociation: [String]?
}

// MARK: - App Clips

public extension AppEntitlements {
    /// com.apple.developer.on-demand-install-capable.
    ///
    /// See [com.apple.developer.on-demand-install-capable](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.on-demand-install-capable)
    @Entitlement(.onDemandInstallCapable)
    static var onDemandInstallCapable: Bool?

    /// Parent Application Identifiers Entitlement.
    ///
    /// See [Parent Application Identifiers Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.parent-application-identifiers)
    @Entitlement(.parentApplicationIdentifiers)
    static var parentApplicationIdentifiers: [String]?
}

@available(iOS 15.4, *)
public extension AppEntitlements {
    /// com.apple.developer.associated-appclip-app-identifiers.
    ///
    /// See [com.apple.developer.associated-appclip-app-identifiers](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.associated-appclip-app-identifiers)
    @Entitlement(.associatedAppclipAppIdentifiers)
    static var associatedAppclipAppIdentifiers: [String]?
}

// MARK: - AppIntents

@available(iOS 26.2, *)
public extension AppEntitlements {
    /// Side Button Invocation.
    ///
    /// See [Side Button Invocation](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.side-button-access.allow)
    @Entitlement(.sideButtonAccessAllow)
    static var sideButtonAccessAllow: Bool?
}

// MARK: - AppMigrationKit

@available(iOS 26.1, *)
public extension AppEntitlements {
    /// App Identifier for OS Data Transfer.
    ///
    /// See [App Identifier for OS Data Transfer](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.app-migration.data-container-access)
    @Entitlement(.appMigrationDataContainerAccess)
    static var appMigrationDataContainerAccess: [String]?
}

// MARK: - Background tasks

@available(iOS 26.0, *)
public extension AppEntitlements {
    /// Background GPU Access.
    ///
    /// See [Background GPU Access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.background-tasks.continued-processing.gpu)
    @Entitlement(.backgroundTasksContinuedProcessingGpu)
    static var backgroundTasksContinuedProcessingGpu: Bool?
}

// MARK: - CarPlay

public extension AppEntitlements {
    /// com.apple.developer.carplay-audio.
    ///
    /// See [com.apple.developer.carplay-audio](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carplay-audio)
    @Entitlement(.carplayAudio)
    static var carplayAudio: Bool?

    /// com.apple.developer.carplay-charging.
    ///
    /// See [com.apple.developer.carplay-charging](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carplay-charging)
    @Entitlement(.carplayCharging)
    static var carplayCharging: Bool?

    /// com.apple.developer.carplay-communication.
    ///
    /// See [com.apple.developer.carplay-communication](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carplay-communication)
    @Entitlement(.carplayCommunication)
    static var carplayCommunication: Bool?

    /// com.apple.developer.carplay-maps.
    ///
    /// See [com.apple.developer.carplay-maps](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carplay-maps)
    @Entitlement(.carplayMaps)
    static var carplayMaps: Bool?

    /// com.apple.developer.carplay-parking.
    ///
    /// See [com.apple.developer.carplay-parking](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carplay-parking)
    @Entitlement(.carplayParking)
    static var carplayParking: Bool?

    /// com.apple.developer.carplay-quick-ordering.
    ///
    /// See [com.apple.developer.carplay-quick-ordering](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carplay-quick-ordering)
    @Entitlement(.carplayQuickOrdering)
    static var carplayQuickOrdering: Bool?
}

// MARK: - CoreTelephony

public extension AppEntitlements {
    /// com.apple.CommCenter.fine-grained.
    ///
    /// See [com.apple.CommCenter.fine-grained](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.commcenter.fine-grained)
    @Entitlement(.commCenterFineGrained)
    static var commCenterFineGrained: [String]?
}

// MARK: - Device Management

@available(iOS 16.0, *)
public extension AppEntitlements {
    /// com.apple.developer.automated-device-enrollment.add-devices.
    ///
    /// See [com.apple.developer.automated-device-enrollment.add-devices](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.automated-device-enrollment.add-devices)
    @Entitlement(.automatedDeviceEnrollmentAddDevices)
    static var automatedDeviceEnrollmentAddDevices: Bool?
}

// MARK: - Email clients

public extension AppEntitlements {
    /// com.apple.developer.mail-client.
    ///
    /// See [com.apple.developer.mail-client](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.mail-client)
    @Entitlement(.mailClient)
    static var mailClient: Bool?
}

// MARK: - EnergyKit

@available(iOS 26.0, *)
public extension AppEntitlements {
    /// com.apple.developer.energykit.
    ///
    /// See [com.apple.developer.energykit](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.energykit)
    @Entitlement(.energykit)
    static var energykit: Bool?
}

// MARK: - Enterprise

public extension AppEntitlements {
    /// Increased performance headroom.
    ///
    /// See [Increased performance headroom](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.app-compute-category)
    @Entitlement(.appComputeCategory)
    static var appComputeCategory: [String]?

    /// Spatial barcode and QR code scanning.
    ///
    /// See [Spatial barcode and QR code scanning](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.arkit.barcode-detection.allow)
    @Entitlement(.arkitBarcodeDetectionAllow)
    static var arkitBarcodeDetectionAllow: Bool?

    /// Camera Region access.
    ///
    /// See [Camera Region access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.arkit.camera-region.allow)
    @Entitlement(.arkitCameraRegionAllow)
    static var arkitCameraRegionAllow: Bool?

    /// Main camera access.
    ///
    /// See [Main camera access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.arkit.main-camera-access.allow)
    @Entitlement(.arkitMainCameraAccessAllow)
    static var arkitMainCameraAccessAllow: Bool?

    /// Object-tracking parameter adjustment.
    ///
    /// See [Object-tracking parameter adjustment](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.arkit.object-tracking-parameter-adjustment.allow)
    @Entitlement(.arkitObjectTrackingParameterAdjustmentAllow)
    static var arkitObjectTrackingParameterAdjustmentAllow: Bool?

    /// Shared Coordinated Space access.
    ///
    /// See [Shared Coordinated Space access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.arkit.shared-coordinate-space.allow)
    @Entitlement(.arkitSharedCoordinateSpaceAllow)
    static var arkitSharedCoordinateSpaceAllow: Bool?

    /// UVC Device Access on visionOS.
    ///
    /// See [UVC Device Access on visionOS](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.avfoundation.uvc-device-access)
    @Entitlement(.avfoundationUvcDeviceAccess)
    static var avfoundationUvcDeviceAccess: Bool?

    /// Apple Neural Engine access.
    ///
    /// See [Apple Neural Engine access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.coreml.neural-engine-access)
    @Entitlement(.coremlNeuralEngineAccess)
    static var coremlNeuralEngineAccess: Bool?

    /// App-Protected Content.
    ///
    /// See [App-Protected Content](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.protected-content)
    @Entitlement(.protectedContent)
    static var protectedContent: Bool?

    /// Passthrough in screen capture.
    ///
    /// See [Passthrough in screen capture](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.screen-capture.include-passthrough)
    @Entitlement(.screenCaptureIncludePassthrough)
    static var screenCaptureIncludePassthrough: Bool?

    /// Follow Mode for Windows.
    ///
    /// See [Follow Mode for Windows](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.window-body-follow)
    @Entitlement(.windowBodyFollow)
    static var windowBodyFollow: Bool?
}

// MARK: - Exposure notification

public extension AppEntitlements {
    /// com.apple.developer.exposure-notification.
    ///
    /// See [com.apple.developer.exposure-notification](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.exposure-notification)
    @Entitlement(.exposureNotification)
    static var exposureNotification: Bool?
}

// MARK: - Family controls

public extension AppEntitlements {
    /// Family Controls.
    ///
    /// See [Family Controls](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.family-controls)
    @Entitlement(.familyControls)
    static var familyControls: Bool?
}

// MARK: - Health

public extension AppEntitlements {
    /// Fall Detection Notifications.
    ///
    /// See [Fall Detection Notifications](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.health.fall-detection)
    @Entitlement(.healthFallDetection)
    static var healthFallDetection: Bool?

    /// HealthKit Entitlement.
    ///
    /// See [HealthKit Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.healthkit)
    @Entitlement(.healthKit)
    static var healthKit: Bool?

    /// HealthKit Capabilities Entitlement.
    ///
    /// See [HealthKit Capabilities Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.healthkit.access)
    @Entitlement(.healthKitCapabilities)
    static var healthKitCapabilities: [String]?

    /// com.apple.developer.healthkit.background-delivery.
    ///
    /// See [com.apple.developer.healthkit.background-delivery](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.healthkit.background-delivery)
    @Entitlement(.healthKitBackgroundDelivery)
    static var healthKitBackgroundDelivery: Bool?

    /// com.apple.developer.healthkit.recalibrate-estimates.
    ///
    /// See [com.apple.developer.healthkit.recalibrate-estimates](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.healthkit.recalibrate-estimates)
    @Entitlement(.healthKitRecalibrateEstimates)
    static var healthKitRecalibrateEstimates: Bool?
}

// MARK: - Home automation

public extension AppEntitlements {
    /// HomeKit Entitlement.
    ///
    /// See [HomeKit Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.homekit)
    @Entitlement(.homeKit)
    static var homeKit: Bool?
}

// MARK: - IdentityDocumentServices

@available(iOS 26.0, *)
public extension AppEntitlements {
    /// Digital Credentials API - Mobile Document Provider.
    ///
    /// See [Digital Credentials API - Mobile Document Provider](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.identity-document-services.document-provider.mobile-document-types)
    @Entitlement(.identityDocumentServicesDocumentProviderMobileDocumentTypes)
    static var identityDocumentServicesDocumentProviderMobileDocumentTypes: [String]?
}

// MARK: - Journaling Suggestions

@available(iOS 17.2, *)
public extension AppEntitlements {
    /// com.apple.developer.journal.allow.
    ///
    /// See [com.apple.developer.journal.allow](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.journal.allow)
    @Entitlement(.journalAllow)
    static var journalAllow: [String]?
}

// MARK: - LiveCommunicationKit

@available(iOS 18.2, watchOS 11.2, *)
public extension AppEntitlements {
    /// Default Calling App.
    ///
    /// See [Default Calling App](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.calling-app)
    @Entitlement(.callingApp)
    static var callingApp: Bool?
}

@available(iOS 26.0, *)
public extension AppEntitlements {
    /// Default Dialer App.
    ///
    /// See [Default Dialer App](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.dialing-app)
    @Entitlement(.dialingApp)
    static var dialingApp: Bool?
}

// MARK: - Managed App Distribution

@available(iOS 17.2, *)
public extension AppEntitlements {
    /// Managed App Installation UI.
    ///
    /// See [Managed App Installation UI](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.managed-app-distribution.install-ui)
    @Entitlement(.managedAppDistributionInstallUi)
    static var managedAppDistributionInstallUi: [String]?
}

// MARK: - Media

@available(iOS 16.0, *)
public extension AppEntitlements {
    /// Media Device Discovery Extension.
    ///
    /// See [Media Device Discovery Extension](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.media-device-discovery-extension)
    @Entitlement(.mediaDeviceDiscoveryExtension)
    static var mediaDeviceDiscoveryExtension: Bool?
}

@available(iOS, introduced: 15.0, deprecated: 18.0)
public extension AppEntitlements {
    /// com.apple.developer.avfoundation.multitasking-camera-access.
    ///
    /// See [com.apple.developer.avfoundation.multitasking-camera-access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.avfoundation.multitasking-camera-access)
    @Entitlement(.avfoundationMultitaskingCameraAccess)
    static var avfoundationMultitaskingCameraAccess: Bool?
}

// MARK: - Memory

public extension AppEntitlements {
    /// Extended Virtual Addressing Entitlement.
    ///
    /// See [Extended Virtual Addressing Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.kernel.extended-virtual-addressing)
    @Entitlement(.kernelExtendedVirtualAddressing)
    static var kernelExtendedVirtualAddressing: Bool?

    /// com.apple.developer.kernel.increased-memory-limit.
    ///
    /// See [com.apple.developer.kernel.increased-memory-limit](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.kernel.increased-memory-limit)
    @Entitlement(.kernelIncreasedMemoryLimit)
    static var kernelIncreasedMemoryLimit: Bool?
}

// MARK: - MessageUI

@available(iOS 17.0, *)
public extension AppEntitlements {
    /// com.apple.developer.upi-device-validation.
    ///
    /// See [com.apple.developer.upi-device-validation](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.upi-device-validation)
    @Entitlement(.upiDeviceValidation)
    static var upiDeviceValidation: Bool?
}

// MARK: - Messages

@available(iOS 18.2, *)
public extension AppEntitlements {
    /// Default Messaging App.
    ///
    /// See [Default Messaging App](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.messaging-app)
    @Entitlement(.messagingApp)
    static var messagingApp: Bool?
}

@available(iOS 18.2, watchOS 11.2, *)
public extension AppEntitlements {
    /// Critical Messaging.
    ///
    /// See [Critical Messaging](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.messages.critical-messaging)
    @Entitlement(.messagesCriticalMessaging)
    static var messagesCriticalMessaging: Bool?
}

// MARK: - Navigation

@available(iOS 18.4, *)
public extension AppEntitlements {
    /// Default Navigation.
    ///
    /// See [Default Navigation](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.navigation-app)
    @Entitlement(.navigationApp)
    static var navigationApp: Bool?
}

// MARK: - NearbyInteraction

@available(iOS 26.1, *)
public extension AppEntitlements {
    /// Nearby Interaction NI DL-TDOA API (development).
    ///
    /// See [Nearby Interaction NI DL-TDOA API (development)](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nearbyinteraction.dltdoa)
    @Entitlement(.nearbyinteractionDltdoa)
    static var nearbyinteractionDltdoa: Bool?
}

// MARK: - Networking

public extension AppEntitlements {
    /// com.apple.developer.networking.manage-thread-network-credentials.
    ///
    /// See [com.apple.developer.networking.manage-thread-network-credentials](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.manage-thread-network-credentials)
    @Entitlement(.networkingManageThreadNetworkCredentials)
    static var networkingManageThreadNetworkCredentials: Bool?

    /// com.apple.developer.networking.multicast.
    ///
    /// See [com.apple.developer.networking.multicast](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.multicast)
    @Entitlement(.networkingMulticast)
    static var networkingMulticast: Bool?
}

@available(iOS 17.0, *)
public extension AppEntitlements {
    /// 5G Network Slicing App Category.
    ///
    /// See [5G Network Slicing App Category](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.slicing.appcategory)
    @Entitlement(.networkingSlicingAppcategory)
    static var networkingSlicingAppcategory: [String]?

    /// 5G Network Slicing Traffic Category.
    ///
    /// See [5G Network Slicing Traffic Category](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.slicing.trafficcategory)
    @Entitlement(.networkingSlicingTrafficcategory)
    static var networkingSlicingTrafficcategory: [String]?
}

@available(iOS 26.0, *)
public extension AppEntitlements {
    /// com.apple.developer.networking.carrier-constrained.app-optimized.
    ///
    /// See [com.apple.developer.networking.carrier-constrained.app-optimized](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.carrier-constrained.app-optimized)
    @Entitlement(.networkingCarrierConstrainedAppOptimized)
    static var networkingCarrierConstrainedAppOptimized: Bool?

    /// com.apple.developer.networking.carrier-constrained.appcategory.
    ///
    /// See [com.apple.developer.networking.carrier-constrained.appcategory](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.carrier-constrained.appcategory)
    @Entitlement(.networkingCarrierConstrainedAppcategory)
    static var networkingCarrierConstrainedAppcategory: [String]?
}

// MARK: - PassKit

public extension AppEntitlements {
    /// Pass Presentation Suppression.
    ///
    /// See [Pass Presentation Suppression](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.passkit.pass-presentation-suppression)
    @Entitlement(.passkitPassPresentationSuppression)
    static var passkitPassPresentationSuppression: Bool?
}

// MARK: - Privacy

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
public extension AppEntitlements {
    /// com.apple.developer.device-information.user-assigned-device-name.
    ///
    /// See [com.apple.developer.device-information.user-assigned-device-name](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.device-information.user-assigned-device-name)
    @Entitlement(.deviceInformationUserAssignedDeviceName)
    static var deviceInformationUserAssignedDeviceName: Bool?
}

// MARK: - Push to Talk

@available(iOS 16.0, *)
public extension AppEntitlements {
    /// Push to Talk Entitlement.
    ///
    /// See [Push to Talk Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.push-to-talk)
    @Entitlement(.pushToTalk)
    static var pushToTalk: Bool?
}

// MARK: - SafetyKit

@available(iOS 16.0, watchOS 10.1, *)
public extension AppEntitlements {
    /// com.apple.developer.severe-vehicular-crash-event.
    ///
    /// See [com.apple.developer.severe-vehicular-crash-event](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.severe-vehicular-crash-event)
    @Entitlement(.severeVehicularCrashEvent)
    static var severeVehicularCrashEvent: Bool?
}

// MARK: - SecureElementCredential

@available(iOS 18.1, *)
public extension AppEntitlements {
    /// com.apple.developer.secure-element-credential.
    ///
    /// See [com.apple.developer.secure-element-credential](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.secure-element-credential)
    @Entitlement(.secureElementCredential)
    static var secureElementCredential: Bool?

    /// com.apple.developer.secure-element-credential.default-contactless-app.
    ///
    /// See [com.apple.developer.secure-element-credential.default-contactless-app](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.secure-element-credential.default-contactless-app)
    @Entitlement(.secureElementCredentialDefaultContactlessApp)
    static var secureElementCredentialDefaultContactlessApp: Bool?
}

// MARK: - Sensitive Content Analysis

@available(iOS 17.0, *)
public extension AppEntitlements {
    /// com.apple.developer.sensitivecontentanalysis.client.
    ///
    /// See [com.apple.developer.sensitivecontentanalysis.client](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.sensitivecontentanalysis.client)
    @Entitlement(.sensitivecontentanalysisClient)
    static var sensitivecontentanalysisClient: [String]?
}

// MARK: - Sensors

public extension AppEntitlements {
    /// com.apple.developer.sensorkit.reader.allow.
    ///
    /// See [com.apple.developer.sensorkit.reader.allow](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.sensorkit.reader.allow)
    @Entitlement(.sensorkitReaderAllow)
    static var sensorkitReaderAllow: [String]?
}

// MARK: - Siri

public extension AppEntitlements {
    /// Siri Entitlement.
    ///
    /// See [Siri Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.siri)
    @Entitlement(.siri)
    static var siri: Bool?
}

// MARK: - StoreKit

@available(iOS 15.4, tvOS 16.4, *)
public extension AppEntitlements {
    /// com.apple.developer.storekit.external-link.account.
    ///
    /// See [com.apple.developer.storekit.external-link.account](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.storekit.external-link.account)
    @Entitlement(.storekitExternalLinkAccount)
    static var storekitExternalLinkAccount: Bool?
}

@available(iOS 18.2, *)
public extension AppEntitlements {
    /// com.apple.developer.storekit.external-purchase-link-streaming.
    ///
    /// See [com.apple.developer.storekit.external-purchase-link-streaming](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.storekit.external-purchase-link-streaming)
    @Entitlement(.storekitExternalPurchaseLinkStreaming)
    static var storekitExternalPurchaseLinkStreaming: Bool?
}

// MARK: - TV

public extension AppEntitlements {
    /// User Management Entitlement.
    ///
    /// See [User Management Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.user-management)
    @Entitlement(.userManagement)
    static var userManagement: [String]?
}

// MARK: - TelephonyMessagingKit

@available(iOS 26.0, *)
public extension AppEntitlements {
    /// Default Carrier Messaging App.
    ///
    /// See [Default Carrier Messaging App](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.carrier-messaging-app)
    @Entitlement(.carrierMessagingApp)
    static var carrierMessagingApp: Bool?
}

// MARK: - Translation

@available(iOS 18.4, *)
public extension AppEntitlements {
    /// Translation.
    ///
    /// See [Translation](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.translation-app)
    @Entitlement(.translationApp)
    static var translationApp: Bool?
}

// MARK: - Vision

public extension AppEntitlements {
    /// com.apple.developer.foveated-streaming-session.
    ///
    /// See [com.apple.developer.foveated-streaming-session](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.foveated-streaming-session)
    @Entitlement(.foveatedStreamingSession)
    static var foveatedStreamingSession: Bool?

    /// Low-Latency Streaming.
    ///
    /// See [Low-Latency Streaming](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.low-latency-streaming)
    @Entitlement(.lowLatencyStreaming)
    static var lowLatencyStreaming: Bool?
}

// MARK: - Wallet

public extension AppEntitlements {
    /// Merchant IDs Entitlement.
    ///
    /// See [Merchant IDs Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.in-app-payments)
    @Entitlement(.merchantIdentifiers)
    static var merchantIdentifiers: [String]?

    /// Pass Type IDs Entitlement.
    ///
    /// See [Pass Type IDs Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.pass-type-identifiers)
    @Entitlement(.passTypeIdentifiers)
    static var passTypeIdentifiers: [String]?
}

@available(iOS 16.0, *)
public extension AppEntitlements {
    /// com.apple.developer.in-app-identity-presentment.
    ///
    /// See [com.apple.developer.in-app-identity-presentment](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.in-app-identity-presentment)
    @Entitlement(.inAppIdentityPresentment)
    static var inAppIdentityPresentment: PropertyListValue?

    /// com.apple.developer.in-app-identity-presentment.merchant-identifiers.
    ///
    /// See [com.apple.developer.in-app-identity-presentment.merchant-identifiers](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.in-app-identity-presentment.merchant-identifiers)
    @Entitlement(.inAppIdentityPresentmentMerchantIdentifiers)
    static var inAppIdentityPresentmentMerchantIdentifiers: [String]?
}

@available(iOS 17.0, *)
public extension AppEntitlements {
    /// ID Verifier - Display Only.
    ///
    /// See [ID Verifier - Display Only](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.proximity-reader.identity.display)
    @Entitlement(.proximityReaderIdentityDisplay)
    static var proximityReaderIdentityDisplay: Bool?

    /// ID Verifier - Data Transfer.
    ///
    /// See [ID Verifier - Data Transfer](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.proximity-reader.identity.read)
    @Entitlement(.proximityReaderIdentityRead)
    static var proximityReaderIdentityRead: PropertyListValue?
}

// MARK: - Web browsers

public extension AppEntitlements {
    /// com.apple.developer.web-browser.
    ///
    /// See [com.apple.developer.web-browser](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser)
    @Entitlement(.webBrowser)
    static var webBrowser: Bool?
}

@available(iOS 17.4, *)
public extension AppEntitlements {
    /// com.apple.developer.browser.app-installation.
    ///
    /// See [com.apple.developer.browser.app-installation](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.browser.app-installation)
    @Entitlement(.browserAppInstallation)
    static var browserAppInstallation: Bool?
}

// MARK: - Wi-Fi Aware

@available(iOS 26.0, *)
public extension AppEntitlements {
    /// com.apple.developer.wifi-aware.
    ///
    /// See [com.apple.developer.wifi-aware](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.wifi-aware)
    @Entitlement(.wifiAware)
    static var wifiAware: [String]?
}

// MARK: - Wi-Fi Infrastructure

@available(iOS 26.2, *)
public extension AppEntitlements {
    /// com.apple.developer.wifi-infrastructure.
    ///
    /// See [com.apple.developer.wifi-infrastructure](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.wifi-infrastructure)
    @Entitlement(.wifiInfrastructure)
    static var wifiInfrastructure: [String]?
}

// MARK: - Wireless insights

@available(iOS 26.0, *)
public extension AppEntitlements {
    /// Wireless Insights Service Predictions.
    ///
    /// See [Wireless Insights Service Predictions](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.wireless-insights.service-predictions)
    @Entitlement(.wirelessInsightsServicePredictions)
    static var wirelessInsightsServicePredictions: Bool?
}

// MARK: - Wireless interfaces

public extension AppEntitlements {
    /// Hotspot Configuration Entitlement.
    ///
    /// See [Hotspot Configuration Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.hotspotconfiguration)
    @Entitlement(.hotspotConfiguration)
    static var hotspotConfiguration: Bool?

    /// HotSpot Helper.
    ///
    /// See [HotSpot Helper](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.hotspothelper)
    @Entitlement(.networkingHotspotHelper)
    static var networkingHotspotHelper: Bool?

    /// Multipath Entitlement.
    ///
    /// See [Multipath Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.multipath)
    @Entitlement(.multipath)
    static var multipath: Bool?

    /// Access Wi-Fi Information Entitlement.
    ///
    /// See [Access Wi-Fi Information Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.wifi-info)
    @Entitlement(.accessWiFiInformation)
    static var accessWiFiInformation: Bool?

    /// ISO18092 system codes for NFC Tag Reader Session.
    ///
    /// See [ISO18092 system codes for NFC Tag Reader Session](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nfc.readersession.felica.systemcodes)
    @Entitlement(.nfcReadersessionFelicaSystemcodes)
    static var nfcReadersessionFelicaSystemcodes: [String]?

    /// Near Field Communication Tag Reader Session Formats Entitlement.
    ///
    /// See [Near Field Communication Tag Reader Session Formats Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nfc.readersession.formats)
    @Entitlement(.nearFieldCommunicationTagReaderSessionFormats)
    static var nearFieldCommunicationTagReaderSessionFormats: [String]?

    /// ISO7816 application identifiers for NFC Tag Reader Session.
    ///
    /// See [ISO7816 application identifiers for NFC Tag Reader Session](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nfc.readersession.iso7816.select-identifiers)
    @Entitlement(.nfcReadersessionIsoSelectIdentifiers)
    static var nfcReadersessionIsoSelectIdentifiers: [String]?

    /// Wireless Accessory Configuration Entitlement.
    ///
    /// See [Wireless Accessory Configuration Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.external-accessory.wireless-configuration)
    @Entitlement(.wirelessAccessoryConfiguration)
    static var wirelessAccessoryConfiguration: Bool?
}

@available(iOS 17.4, *)
public extension AppEntitlements {
    /// com.apple.developer.nfc.hce.
    ///
    /// See [com.apple.developer.nfc.hce](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nfc.hce)
    @Entitlement(.nfcHce)
    static var nfcHce: Bool?

    /// com.apple.developer.nfc.hce.default-contactless-app.
    ///
    /// See [com.apple.developer.nfc.hce.default-contactless-app](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nfc.hce.default-contactless-app)
    @Entitlement(.nfcHceDefaultContactlessApp)
    static var nfcHceDefaultContactlessApp: Bool?

    /// com.apple.developer.nfc.hce.iso7816.select-identifier-prefixes.
    ///
    /// See [com.apple.developer.nfc.hce.iso7816.select-identifier-prefixes](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.nfc.hce.iso7816.select-identifier-prefixes)
    @Entitlement(.nfcHceIsoSelectIdentifierPrefixes)
    static var nfcHceIsoSelectIdentifierPrefixes: [String]?
}

public extension AppEntitlements {
    /// Data Protection Entitlement.
    ///
    /// See [Data Protection Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.default-data-protection)
    @Entitlement(.defaultDataProtection)
    static var defaultDataProtection: FileProtectionType?

    /// App Attest Environment.
    ///
    /// See [App Attest Environment](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.devicecheck.appattest-environment)
    @Entitlement(.deviceCheckAppAttestEnvironment)
    static var deviceCheckAppAttestEnvironment: String?
}
