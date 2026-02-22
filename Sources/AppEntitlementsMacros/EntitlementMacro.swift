public import AppEntitlementsCore

/// Adds a throwing getter that reads the value for a known entitlement identifier.
///
/// Example:
///
/// ```swift
/// @Entitlement(.teamIdentifier)
/// static var teamIdentifier: String?
/// ```
@attached(accessor)
public macro Entitlement(_ identifier: Entitlement) = #externalMacro(
    module: "AppEntitlementsMacrosPlugin",
    type: "EntitlementMacro"
)

/// Adds a throwing getter that reads the value for a custom entitlement identifier.
///
/// The identifier type must conform to `EntitlementIdentifying`.
///
/// Example:
///
/// ```swift
/// @Entitlement(CustomEntitlement.testEntitlement)
/// static var customValue: String?
/// ```
@attached(accessor)
public macro Entitlement<Identifier: EntitlementIdentifying>(_ identifier: Identifier) = #externalMacro(
    module: "AppEntitlementsMacrosPlugin",
    type: "EntitlementMacro"
)
