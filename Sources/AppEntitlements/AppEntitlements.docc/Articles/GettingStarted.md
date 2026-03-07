# Getting Started

Learn how to integrate and use AppEntitlements in your Apple platform applications.

## Modules

The package provides two products:

- **AppEntitlements** - Core module with 13 common entitlement properties and the `getValue`/`getArray` APIs. No build plugin, no trust prompt.
- **AppEntitlementsCatalog** - Extends `AppEntitlements` with 150+ type-safe properties generated from Apple's entitlement metadata via a build plugin. Requires a one-time trust prompt in Xcode.

> Note: `AppEntitlementsCatalog` requires each developer to trust the build plugin once on their machine. For CI/CD environments, see [Xcode's documentation on plugin trust](https://developer.apple.com/documentation/xcode/running-build-tool-plug-ins).

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

## Troubleshooting

If you encounter issues with entitlements:

- Verify your app's provisioning profile includes the required entitlements
- Check that your entitlements file (`.entitlements`) is properly configured
- Review Apple's [Diagnosing Issues with Entitlements](https://developer.apple.com/documentation/bundleresources/diagnosing-issues-with-entitlements) guide

## Next Steps

- Explore <doc:CommonEntitlements>
- Handle <doc:CustomEntitlements>
- Learn about <doc:ReadingExecutableEntitlements>
