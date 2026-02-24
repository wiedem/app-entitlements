# Getting Started

Learn how to integrate and use AppEntitlements in your Apple platform applications.

## Installation

Add AppEntitlements to your project using Swift Package Manager.

### Swift Package Manager

Add the package dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/wiedem/app-entitlements.git", from: "2.0.0")
]
```

Then add the product(s) to your target:

```swift
.target(
    name: "YourApp",
    dependencies: [
        // Core — no build plugin, no trust prompt
        .product(name: "AppEntitlements", package: "app-entitlements"),

        // Optional: Extended entitlements catalog — includes build plugin, one-time trust prompt
        .product(name: "AppEntitlementsCatalog", package: "app-entitlements"),
    ]
)
```

Or in Xcode:
1. File → Add Package Dependencies...
2. Enter: [https://github.com/wiedem/app-entitlements.git](https://github.com/wiedem/app-entitlements.git)

### Requirements

- iOS 15.0+
- macOS 12.0+
- tvOS 15.0+
- visionOS 1.0+
- watchOS 8.0+
- Swift 6.0+
- Xcode 16.0+

## Basic Usage

Import the package and access entitlements through static properties.

```swift
import AppEntitlements

do {
    if let appID = try AppEntitlements.applicationIdentifier {
        print("App ID: \(appID)")
    }

    if let keychainGroups = try AppEntitlements.keychainAccessGroups {
        print("Keychain Groups: \(keychainGroups.joined(separator: ", "))")
    }

    if let isDebug = try AppEntitlements.getTaskAllow {
        print("Debug mode: \(isDebug)")
    }
} catch {
    print("Error reading entitlements: \(error)")
}
```

### Return Values

- Properties return `nil` when an entitlement is not present
- Throws errors when entitlements cannot be accessed or parsed
- All properties are optional (`String?`, `Bool?`, `[String]?`, etc.)

## Extended Entitlements Catalog

The optional `AppEntitlementsCatalog` module provides 150+ type-safe properties generated from Apple's entitlement metadata. It uses a build plugin for code generation, which triggers a one-time trust prompt in Xcode.

```swift
import AppEntitlementsCatalog

let networkExtension = try AppEntitlements.networkExtension
```

> Note: Each developer needs to trust the plugin once on their machine. For CI/CD environments, see [Xcode's documentation on plugin trust](https://developer.apple.com/documentation/xcode/running-build-tool-plug-ins).

## Accessing Custom Entitlements

For entitlements without built-in properties, use ``AppEntitlements/AppEntitlements/getValue(for:as:transform:)-5s4fs``:

```swift
let newFeature: Bool? = try AppEntitlements.getValue(
    for: "com.apple.developer.new-feature"
)
```

### Creating Convenience Extensions

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

## Supported Types

### Basic Types
The ``AppEntitlements/AppEntitlements/getValue(for:as:transform:)-5s4fs`` method supports common Swift types:
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

## Troubleshooting

If you encounter issues with entitlements:

- Verify your app's provisioning profile includes the required entitlements
- Check that your entitlements file (`.entitlements`) is properly configured
- Review Apple's [Diagnosing Issues with Entitlements](https://developer.apple.com/documentation/bundleresources/diagnosing-issues-with-entitlements) guide

## Next Steps

- Explore <doc:CommonEntitlements>
- Handle <doc:CustomEntitlements>
- Learn about <doc:ReadingExecutableEntitlements>
