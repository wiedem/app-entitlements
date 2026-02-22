# ``AppEntitlements/AppEntitlements/getArray(for:elementType:transform:)-(String,_,_)``

## Example

```swift
do {
    let groups: [String]? = try AppEntitlements.getArray(
        for: "keychain-access-groups"
    )
    
    if let groups = groups {
        for group in groups {
            print("Keychain group: \(group)")
        }
    }
} catch {
    print("Error: \(error)")
}
```

