# ``AppEntitlements/AppEntitlements/getValue(for:as:transform:)-5s4fs``

## Example

```swift
do {
    let value: String? = try AppEntitlements.getValue(
        for: "com.apple.developer.new-feature"
    )
    
    if let value = value {
        print("Feature: \(value)")
    }
} catch {
    print("Error: \(error)")
}
```

