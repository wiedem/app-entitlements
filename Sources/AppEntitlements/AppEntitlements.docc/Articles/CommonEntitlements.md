# Common Entitlements

Access to the most frequently used entitlements through built-in properties.

## Overview

The `AppEntitlements` core module provides 13 type-safe properties for the most common entitlements. These are available without a build plugin and cover application identity, data sharing, push notifications, iCloud, and development workflows.

For entitlements not listed here, use ``AppEntitlements/getValue(for:as:transform:)-5s4fs`` to access any entitlement by its key. See <doc:CustomEntitlements> for details.

## Core Entitlements

### Application Identity

- ``AppEntitlements/applicationIdentifier`` - Unique app identifier (team ID + bundle ID)
- ``AppEntitlements/teamIdentifier`` - Apple Developer Team ID

### Access Groups & Sharing

- ``AppEntitlements/keychainAccessGroups`` - Groups for shared keychain access
- ``AppEntitlements/applicationGroups`` - App groups for shared container access
- ``AppEntitlements/associatedDomains`` - Associated domains for universal links

### Push Notifications

- ``AppEntitlements/apsEnvironment`` - Apple Push Notification service environment

### Data Protection

- ``AppEntitlements/defaultDataProtection`` - Default file protection level

### Device Check

- ``AppEntitlements/deviceCheckAppAttestEnvironment`` - App Attest environment

### iCloud

- ``AppEntitlements/iCloudContainerIdentifiers`` - iCloud container identifiers
- ``AppEntitlements/iCloudContainerEnvironment`` - iCloud container environment
- ``AppEntitlements/iCloudKeyValueStore`` - iCloud key-value store identifier
- ``AppEntitlements/iCloudServices`` - Enabled iCloud services

### Development

- ``AppEntitlements/getTaskAllow`` - Indicates if debugging is allowed

## Additional Resources

For a complete list of available entitlements and detailed documentation:

- [Entitlements Reference](https://developer.apple.com/documentation/bundleresources/entitlements) - Complete catalog of Apple entitlements
- [Diagnosing Issues with Entitlements](https://developer.apple.com/documentation/bundleresources/diagnosing-issues-with-entitlements) - Troubleshooting guide

> Tip: The optional `AppEntitlementsCatalog` module provides 150+ additional type-safe properties generated from Apple's entitlement metadata.
