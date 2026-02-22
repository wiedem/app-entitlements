# ``AppEntitlements/AppEntitlements/getArray(for:elementType:transform:)-(EntitlementIdentifying,_,_)``

## Example

```swift
struct CustomArrayEntitlement: EntitlementIdentifying {
    var entitlementID: String { "com.example.custom-list" }
}

do {
    let items: [String]? = try AppEntitlements.getArray(
        for: CustomArrayEntitlement()
    )
    
    if let items = items {
        for item in items {
            print("Item: \(item)")
        }
    }
} catch {
    print("Error: \(error)")
}
```

