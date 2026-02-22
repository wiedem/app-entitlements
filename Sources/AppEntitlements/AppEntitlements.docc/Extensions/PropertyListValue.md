# ``PropertyListValue``

Type-safe representation of property list values.

## Overview

``PropertyListValue`` is an enum that represents all possible types that can appear in property lists and entitlement dictionaries. It provides type-safe access to entitlement values on iOS.

## Topics

### Value Cases

- ``array(_:)``
- ``dictionary(_:)``
- ``data(_:)``
- ``string(_:)``
- ``date(_:)``
- ``int32(_:)``
- ``int64(_:)``
- ``float(_:)``
- ``double(_:)``
- ``bool(_:)``

### Extracting Values

Use the `value(_:)` method to safely extract typed values from property list values.

### Error Handling

- ``PropertyListValueError``
