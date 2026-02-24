# ``AppEntitlements/AppEntitlements/getValue(for:as:transform:)-5awjy``

## Example

```swift
enum CustomEntitlement: String, EntitlementIdentifying {
    case customFeature = "com.example.custom-feature"

    var entitlementID: String { rawValue }
}

do {
    let value: String? = try AppEntitlements.getValue(
        for: CustomEntitlement.customFeature
    )
    
    if let value = value {
        print("Custom feature: \(value)")
    }
} catch {
    print("Error: \(error)")
}
```
