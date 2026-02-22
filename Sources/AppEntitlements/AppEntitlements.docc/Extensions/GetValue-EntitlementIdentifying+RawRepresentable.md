# ``AppEntitlements/AppEntitlements/getValue(for:as:transform:)-8iqy8``

## Example

```swift
enum CustomEnvironment: String, EntitlementIdentifying {
    case development = "Development"
    case production = "Production"
    
    var entitlementID: String { "com.example.environment" }
}
do {
    let env: CustomEnvironment? = try AppEntitlements.getValue(
        for: CustomEnvironment.self
    )
    
    if let env = env {
        print("Environment: \(env)")
    }
} catch {
    print("Error: \(error)")
}
```

