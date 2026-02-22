# ``AppEntitlements/AppEntitlements``

A container for application entitlement types and methods.

## Overview

The `AppEntitlements` enum serves as a namespace for accessing app entitlements at runtime. All functionality is exposed through static properties and methods.

## Topics

### Application Identity

- ``applicationIdentifier``
- ``teamIdentifier``

### Development & Distribution

- ``getTaskAllow``
- ``apsEnvironment``

### Data Protection & Sharing

- ``keychainAccessGroups``
- ``applicationGroups``
- ``associatedDomains``

### Reading from Executables

- ``entitlements(fromExecutableAt:)``

### Custom Entitlements

- <doc:CustomEntitlements>

### Error Handling

- ``EntitlementsError``
