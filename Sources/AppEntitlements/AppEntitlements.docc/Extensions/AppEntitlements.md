# ``AppEntitlements``

Type-safe runtime access to app entitlements for iOS and macOS applications.

## Overview

**AppEntitlements** provides a Swift API for reading your app's entitlements at runtime. This is useful for:

- Checking which [App Groups](doc:AppEntitlements/AppEntitlements/applicationGroups) or [Keychain Access Groups](doc:AppEntitlements/AppEntitlements/keychainAccessGroups) are configured
- Determining the [push notification environment](doc:AppEntitlements/AppEntitlements/apsEnvironment) (development or production)
- Validating your app's [capabilities and permissions](doc:CommonEntitlements)
- Debugging entitlement-related issues
- Implementing conditional features based on entitlements

### Quick Example

```swift
import AppEntitlements

// Access common entitlements with type-safe properties
let appID = try AppEntitlements.applicationIdentifier
let groups = try AppEntitlements.keychainAccessGroups
```

### Key Features

- **Type-safe API** - Swift properties instead of string-based lookups
- **Multiple formats** - Supports PropertyList and [DER-encoded](https://developer.apple.com/documentation/technotes/tn3125-inside-code-signing-provisioning-profiles#The-future-is-DER) entitlements
- **Thread-safe** - All APIs are `Sendable` and concurrency-safe
- **Swift 6** - Built with strict concurrency

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:CommonEntitlements>
- <doc:CustomEntitlements>

### Advanced

- <doc:ReadingExecutableEntitlements>

### Types

- ``PropertyListValue``
- ``ApsEnvironment``
- ``ClassKitEnvironment``
- ``ICloudContainerEnvironment``

### Errors

- ``AppEntitlements/EntitlementsError``
- ``PropertyListValueError``
- ``AppEntitlements/DEREncodingError``
