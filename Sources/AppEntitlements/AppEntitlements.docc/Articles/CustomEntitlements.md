# Custom Entitlements

Access any entitlement that doesn't have a built-in property.

## Overview

While AppEntitlements provides convenient properties for frequently used entitlements (see <doc:CommonEntitlements>), you can access **any** entitlement using ``AppEntitlements/getValue(for:as:transform:)-5s4fs``. This is useful for:

- New Apple entitlements not yet added to the package
- Less commonly used entitlements
- Custom or third-party entitlements
- App-specific entitlements

For a complete list of available Apple entitlements, see [Entitlements Reference](https://developer.apple.com/documentation/bundleresources/entitlements).

## Direct Access with getValue

Use ``AppEntitlements/getValue(for:as:transform:)-5s4fs`` to retrieve any entitlement by its key:

```swift
// Access a new Apple entitlement
do {
    let value: Bool? = try AppEntitlements.getValue(
        for: "com.apple.developer.new-feature"
    )
    
    if let enabled = value {
        print("Feature enabled: \(enabled)")
    }
} catch {
    print("Error: \(error)")
}
```

## Supported Types

### Basic Types
The ``AppEntitlements/getValue(for:as:transform:)-5s4fs`` method supports common Swift types:
```swift
let stringValue: String? = try AppEntitlements.getValue(for: "key")
let boolValue: Bool? = try AppEntitlements.getValue(for: "key")
let intValue: Int32? = try AppEntitlements.getValue(for: "key")
```

Supported: `String`, `Bool`, `Int32`, `Int64`, `Float`, `Double`, `Data`, `Date`

### Arrays
Use ``AppEntitlements/AppEntitlements/getArray(for:elementType:transform:)-(String,_,_)`` for typed arrays:
```swift
let groups: [String]? = try AppEntitlements.getArray(
    for: "keychain-access-groups",
    elementType: String.self
)
```

### RawRepresentable Types
Any `RawRepresentable` type with `String` as `RawValue` is supported.

Built-in types: ``ApsEnvironment``, ``AppAttestEnvironment``, ``ICloudContainerEnvironment``, ``ICloudService``

```swift
// Examples with built-in types
let apsEnv = try AppEntitlements.apsEnvironment
let attestEnv = try AppEntitlements.deviceCheckAppAttestEnvironment

// Custom RawRepresentable types
enum MyEnvironment: String {
    case dev, prod
}

let env: MyEnvironment? = try AppEntitlements.getValue(
    for: "com.example.environment",
    as: MyEnvironment.self
)
```

### Complex Structures
Use ``PropertyListValue`` for nested data structures:
```swift
let array: [PropertyListValue]? = try AppEntitlements.getValue(for: "key")
let dict: [String: PropertyListValue]? = try AppEntitlements.getValue(for: "key")
```

## Creating Convenience Extensions

For frequently accessed entitlements, create an extension property:

```swift
extension AppEntitlements {
    /// Access to the new iOS 18 feature.
    static var newFeatureEnabled: Bool? {
        get throws {
            try getValue(for: "com.apple.developer.new-feature")
        }
    }
}

// Use like built-in properties
if try AppEntitlements.newFeatureEnabled == true {
    enableNewFeature()
}
```

## Best Practices

1. **Check Existing Properties First**: See <doc:CommonEntitlements> for the 13 core properties. The optional `AppEntitlementsCatalog` module provides 150+ additional properties — check if a property exists there before writing a manual `getValue` call.
2. **Create Extensions for Reuse**: Don't call ``AppEntitlements/getValue(for:as:transform:)-5s4fs`` repeatedly - create a property extension
3. **Document Entitlement Keys**: Include links to Apple documentation when available
4. **Handle Errors**: Every entitlement access can throw errors (e.g. when the code signature cannot be read). Make sure your code handles these cases.

## Additional Resources

- [Entitlements Reference](https://developer.apple.com/documentation/bundleresources/entitlements) - Complete list of Apple entitlements
- [Diagnosing Issues with Entitlements](https://developer.apple.com/documentation/bundleresources/diagnosing-issues-with-entitlements) - Troubleshooting guide
