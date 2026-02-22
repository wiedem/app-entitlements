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

The ``AppEntitlements/getValue(for:as:transform:)-5s4fs`` method automatically converts these Swift types:

- `String`, `Bool`, `Int32`, `Int64`, `Float`, `Double`
- `[String]` - String arrays (use `getArray(for:elementType:transform:)` for typed arrays)
- `Data`, `Date`
- ``PropertyListValue`` - Use for complex structures like arrays and dictionaries

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

## RawRepresentable Types

Any `RawRepresentable` type with `String` as `RawValue` is automatically supported:

```swift
enum CustomEnvironment: String {
    case development
    case production
}

extension AppEntitlements {
    static var customEnvironment: CustomEnvironment? {
        get throws {
            try getValue(for: "com.example.environment", as: CustomEnvironment.self)
        }
    }
}
```

The conversion happens automatically - no transform parameter needed.

## Working with Complex Structures

For nested dictionary or array values, use ``PropertyListValue``:

```swift
// Access a dictionary entitlement
let config = try AppEntitlements.getValue(
    for: "com.example.configuration",
    as: [String: PropertyListValue].self
)

if let dict = config,
   let nested = dict["key"]?.stringValue {
    print("Nested value: \(nested)")
}
```

## App-Specific Entitlements

In rare cases, developers may embed custom entitlements in their apps during the signing process. These can be accessed the same way:

```swift
let customValue = try AppEntitlements.getValue(
    for: "com.mycompany.custom-setting",
    as: String.self
)
```

**Note**: Custom app entitlements are uncommon and require special build configurations.

## Best Practices

1. **Use Built-in Properties First**: Check <doc:CommonEntitlements> to see if a property already exists
2. **Create Extensions for Reuse**: Don't call ``AppEntitlements/getValue(for:as:transform:)-5s4fs`` repeatedly - create a property extension
3. **Document Entitlement Keys**: Include links to Apple documentation when available
4. **Handle Errors Gracefully**: Always wrap in do-catch blocks

## Additional Resources

- [Entitlements Reference](https://developer.apple.com/documentation/bundleresources/entitlements) - Complete list of Apple entitlements
- [Diagnosing Issues with Entitlements](https://developer.apple.com/documentation/bundleresources/diagnosing-issues-with-entitlements) - Troubleshooting guide
