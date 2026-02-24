# AppEntitlements

A Swift package that provides type-safe runtime access to app entitlements for iOS, macOS, tvOS, visionOS, and watchOS applications.

[![Swift 6](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2015+%20|%20macOS%2012+%20|%20tvOS%2015+%20|%20visionOS%201+%20|%20watchOS%208+-blue.svg)](https://swift.org)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE.txt)

## Overview

**AppEntitlements** provides a unified, type-safe API for accessing app entitlements at runtime across all Apple platforms.

### Why This Package?

- **macOS**: The [Security framework](https://developer.apple.com/documentation/security) only provides a C API [SecTaskCopyValueForEntitlement](https://developer.apple.com/documentation/security/sectaskcopyvalueforentitlement(_:_:_:)) that's cumbersome to use from Swift. This package wraps it with type-safe properties.
- **iOS/tvOS/visionOS/watchOS**: Apple provides no public API at all for runtime entitlement access. This package implements direct access by parsing Mach-O code signatures in memory, without using any private APIs (App Store safe).
- **Type Safety**: Swift properties and enums instead of error-prone string-based lookups
- **Modern Swift**: Built with Swift 6, strict concurrency, and comprehensive documentation

## Features

- ✅ **Type-Safe API** - Properties instead of string-based lookups
- ✅ **Extensible** - Easy access to custom entitlements via `getValue` and `getArray`
- ✅ **Swift 6** - Modern Swift with strict concurrency support
- ✅ **Complete Documentation** - DocC documentation with examples and guides
- ✅ **13 Core Entitlements** - Common entitlements available without build plugin
- ✅ **150+ Catalog Entitlements** - Extended Apple entitlements catalog via `AppEntitlementsCatalog`

## Installation

### Swift Package Manager

Add the dependency to your `Package.swift`:

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

Or add it in Xcode:
1. **File → Add Package Dependencies...**
2. Enter: `https://github.com/wiedem/app-entitlements.git`

## Core and Catalog

AppEntitlements provides two modules from a single package:

### AppEntitlements (Core)

Contains the runtime API for accessing entitlements, including 13 commonly used entitlement properties, `getValue`/`getArray` for custom lookups, and the underlying Mach-O/Security framework implementation. No build plugin required.

```swift
import AppEntitlements

if let appID = try AppEntitlements.applicationIdentifier {
    print("App ID: \(appID)")
}

// Access any entitlement by its key
let custom: String? = try AppEntitlements.getValue(
    for: "com.example.custom-entitlement"
)
```

For a complete list of core entitlements and detailed usage, see the [package documentation](https://wiedem.github.io/app-entitlements/documentation/appentitlements/).

### AppEntitlementsCatalog

Extends `AppEntitlements` with 150+ type-safe properties generated from Apple's entitlement metadata via a build plugin. Since the build plugin runs code during compilation, Xcode displays a one-time security prompt when first building with this module.

```swift
import AppEntitlementsCatalog

let networkExtension = try AppEntitlements.networkExtension
```

> **Note:** Each developer needs to trust the plugin once on their machine. For CI/CD environments, see [Xcode's documentation on plugin trust](https://developer.apple.com/documentation/xcode/running-build-tool-plug-ins).

## Error Handling

All entitlement access can throw errors. Always use `try`:

```swift
do {
    if let groups = try AppEntitlements.applicationGroups {
        print("App Groups: \(groups)")
    }
} catch {
    // Handle entitlement access errors
    print("Failed to access entitlements: \(error)")
}
```

Common errors:
- **macOS**: `EntitlementsError.failedToCreateSecurityTask` - Invalid code signature or security context
- **iOS/tvOS/visionOS/watchOS**: `EntitlementsError.failedToLoadLibrary` or `EntitlementsError.failedToLoadExecutableSymbol` - Mach-O parsing issues

## Requirements

- iOS 15.0+ / macOS 12.0+ / tvOS 15.0+ / visionOS 1.0+ / watchOS 8.0+
- Swift 6.0+
- Xcode 16.0+

## Testing

The package includes comprehensive unit tests covering:

- DER decoding with real-world samples
- PropertyList value type conversion
- Code signature blob parsing
- Entitlement data extraction
- Error handling

Run tests via Swift Package Manager:

```bash
swift test
```

Or in Xcode:
```bash
⌘U (Product → Test)
```

## Documentation

Full DocC documentation is available online:

**[AppEntitlements Documentation →](https://wiedem.github.io/app-entitlements/documentation/appentitlements/)**

Build documentation locally:

```bash
swift package generate-documentation
```

Or in Xcode:
```bash
Product → Build Documentation
```

## Contributing

Contributions are welcome! Please feel free to:

- Report bugs or request features via [GitHub Issues](https://github.com/wiedem/app-entitlements/issues)
- Submit pull requests with improvements
- Improve documentation or add examples
- Share feedback on API design

## Data Attribution

Entitlement metadata in this package is derived from publicly available [Apple Developer Documentation](https://developer.apple.com/documentation/bundleresources/entitlements). This package is not affiliated with, endorsed by, or sponsored by Apple Inc.

All entitlement keys, type information, and platform availability data are factual technical specifications extracted from Apple's public documentation. Documentation links reference the original Apple Developer Documentation for detailed information.

## References

- [Apple Developer: Entitlements](https://developer.apple.com/documentation/bundleresources/entitlements)
- [Diagnosing Issues with Entitlements](https://developer.apple.com/documentation/bundleresources/diagnosing-issues-with-entitlements)
- [Apple TechNote: Using the latest code signature format](https://developer.apple.com/documentation/xcode/using-the-latest-code-signature-format)
- [Apple Open Source: Security Framework](https://github.com/apple-opensource/Security/blob/master/codesign_wrapper/check_entitlements.c)
- [Apple Open Source: codesign tool](https://opensource.apple.com/source/security_certtool/)

## License

This project is licensed under the MIT License. See [LICENSE.txt](LICENSE.txt) for details.

## Author

Created and maintained by [Holger Wiedemann](https://github.com/wiedem)

---

**Note**: This package reads code signature data from Mach-O binaries for entitlement access. It does not modify code or signatures in any way.
