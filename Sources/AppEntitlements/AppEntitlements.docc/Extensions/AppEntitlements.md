# ``AppEntitlements``

Type-safe runtime access to app entitlements for iOS, macOS, tvOS, visionOS, and watchOS applications.

## Overview

**AppEntitlements** provides a Swift API for reading your app's entitlements at runtime. This is useful for:

- Checking which [App Groups](doc:AppEntitlements/AppEntitlements/applicationGroups) or [Keychain Access Groups](doc:AppEntitlements/AppEntitlements/keychainAccessGroups) are configured
- Determining the [push notification environment](doc:AppEntitlements/AppEntitlements/apsEnvironment) (development or production)
- Validating your app's [capabilities and permissions](doc:CommonEntitlements)
- Debugging entitlement-related issues
- Implementing conditional features based on entitlements

### Core and Catalog

The core module includes 13 commonly used entitlement properties and the `getValue` / `getArray` APIs for custom lookups.

```swift
import AppEntitlements

let appID = try AppEntitlements.applicationIdentifier
let custom: String? = try AppEntitlements.getValue(for: "com.example.custom")
```

The optional catalog module extends `AppEntitlements` with 150+ additional type-safe properties generated from Apple's entitlement metadata via a build plugin. Since the plugin runs code during compilation, Xcode displays a one-time trust prompt when first building with this module.

```swift
import AppEntitlementsCatalog

let networkExtension = try AppEntitlements.networkExtension
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
- ``AppAttestEnvironment``
- ``ICloudContainerEnvironment``
- ``ICloudService``

### Errors

- ``AppEntitlements/EntitlementsError``
- ``PropertyListValueError``
- ``AppEntitlements/DEREncodingError``
