public import AppEntitlements

extension Entitlement: EntitlementIdentifying {
    public var entitlementID: String {
        rawValue
    }
}
