# Reading Entitlements from Executables

Inspect entitlements in Mach-O executable files.

## Overview

For most cases, use Apple's `codesign` tool to inspect entitlements in app bundles, as described in [Diagnosing Issues with Entitlements](https://developer.apple.com/documentation/bundleresources/diagnosing-issues-with-entitlements#Check-the-Entitlements-In-Your-Build-Log-and-App):

```bash
# Display entitlements for an app bundle
codesign -d --entitlements - /Applications/MyApp.app
```

For programmatic access within Swift code, you can use ``AppEntitlements/entitlements(fromExecutableAt:)`` to read entitlements from Mach-O executable files.

## Programmatic Usage

```swift
import AppEntitlements
import Foundation

let executableURL = URL(fileURLWithPath: "/Applications/Safari.app/Contents/MacOS/Safari")

do {
    let entitlements = try AppEntitlements.entitlements(fromExecutableAt: executableURL)
    
    // Access entitlements using PropertyListValue
    if case let .string(appID) = entitlements["com.apple.application-identifier"] {
        print("App ID: \(appID)")
    }
} catch {
    print("Failed to read entitlements: \(error)")
}
```

## Limitations

### Universal Binaries Not Supported

The method only supports single-architecture Mach-O binaries. Universal (fat) binaries will result in an error.

Extract a specific architecture first using `lipo`:

```bash
# Extract arm64 version
lipo -thin arm64 /path/to/app -output app-arm64
```

## See Also

- ``AppEntitlements/entitlements(fromExecutableAt:)``
- [Diagnosing Issues with Entitlements](https://developer.apple.com/documentation/bundleresources/diagnosing-issues-with-entitlements)
