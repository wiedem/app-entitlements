# Common Entitlements

Access to the most frequently used entitlements through built-in properties.

## Overview

AppEntitlements provides convenient properties for the most common entitlements that developers typically need. These cover application identity, data sharing, and development workflows.

For entitlements not listed here, use ``AppEntitlements/getValue(for:as:transform:)-5s4fs`` to access any entitlement by its key. See <doc:CustomEntitlements> for details.

## Essential Entitlements

### Application Identity

- ``AppEntitlements/applicationIdentifier`` - Unique app identifier (team ID + bundle ID)
- ``AppEntitlements/teamIdentifier`` - Apple Developer Team ID

### Data Sharing

- ``AppEntitlements/keychainAccessGroups`` - Groups for shared keychain access
- ``AppEntitlements/applicationGroups`` - App groups for shared container access

### Development & Distribution

- ``AppEntitlements/getTaskAllow`` - Indicates if debugging is allowed
- ``AppEntitlements/apsEnvironment`` - Apple Push Notification service environment

## Additional Resources

For a complete list of available entitlements and detailed documentation:

- [Entitlements Reference](https://developer.apple.com/documentation/bundleresources/entitlements) - Complete catalog of Apple entitlements
- [Diagnosing Issues with Entitlements](https://developer.apple.com/documentation/bundleresources/diagnosing-issues-with-entitlements) - Troubleshooting guide
> Tip: Many additional entitlements are available as properties in AppEntitlements. Use code completion or check the API documentation for ``AppEntitlements/AppEntitlements`` to explore all available options.
