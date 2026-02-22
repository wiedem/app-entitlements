# ``AppEntitlements/AppEntitlements/getValue(for:as:transform:)-6v4g6``

## Example

```swift
enum Environment: String {
    case development
    case production
}

do {
    let env: Environment? = try AppEntitlements.getValue(
        for: "com.example.environment",
        as: Environment.self
    )
    
    if let env = env {
        print("Environment: \(env)")
    }
} catch {
    print("Error: \(error)")
}
```

