internal import AppEntitlementsCore
internal import AppEntitlementsMacros

// MARK: - FSKit

@available(macOS 15.4, *)
public extension AppEntitlements {
    /// FSKit Module.
    ///
    /// See [FSKit Module](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.fskit.fsmodule)
    @Entitlement(.fskitFsmodule)
    static var fskitFsmodule: Bool?
}

// MARK: - Hypervisor

public extension AppEntitlements {
    /// com.apple.security.hypervisor.
    ///
    /// See [com.apple.security.hypervisor](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.security.hypervisor)
    @Entitlement(.hypervisor)
    static var hypervisor: Bool?

    /// com.apple.security.virtualization.
    ///
    /// See [com.apple.security.virtualization](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.security.virtualization)
    @Entitlement(.virtualization)
    static var virtualization: Bool?

    /// com.apple.vm.device-access.
    ///
    /// See [com.apple.vm.device-access](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.vm.device-access)
    @Entitlement(.vmDeviceAccess)
    static var vmDeviceAccess: Bool?

    /// com.apple.vm.networking.
    ///
    /// See [com.apple.vm.networking](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.vm.networking)
    @Entitlement(.vmNetworking)
    static var vmNetworking: Bool?
}

// MARK: - Networking

public extension AppEntitlements {
    /// com.apple.developer.associated-domains.applinks.read-write.
    ///
    /// See [com.apple.developer.associated-domains.applinks.read-write](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.associated-domains.applinks.read-write)
    @Entitlement(.associatedDomainsApplinksReadWrite)
    static var associatedDomainsApplinksReadWrite: Bool?
}

@available(macOS 14.0, *)
public extension AppEntitlements {
    /// com.apple.developer.networking.vmnet.
    ///
    /// See [com.apple.developer.networking.vmnet](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.networking.vmnet)
    @Entitlement(.networkingVmnet)
    static var networkingVmnet: Bool?
}

// MARK: - ScreenCaptureKit

@available(macOS 14.4, *)
public extension AppEntitlements {
    /// Persistent Content Capture.
    ///
    /// See [Persistent Content Capture](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.persistent-content-capture)
    @Entitlement(.persistentContentCapture)
    static var persistentContentCapture: Bool?
}

// MARK: - Web browsers

@available(macOS 13.3, *)
public extension AppEntitlements {
    /// com.apple.developer.web-browser.public-key-credential.
    ///
    /// See [com.apple.developer.web-browser.public-key-credential](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.web-browser.public-key-credential)
    @Entitlement(.webBrowserPublicKeyCredential)
    static var webBrowserPublicKeyCredential: Bool?
}
