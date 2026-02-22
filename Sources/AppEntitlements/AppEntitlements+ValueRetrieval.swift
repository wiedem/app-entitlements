#if os(macOS)
internal import Security
#endif

// MARK: - Value Retrieval Implementation

public extension AppEntitlements {
    /// Retrieves an entitlement value using a direct identifier and a custom transform.
    ///
    /// This allows custom type conversion beyond the standard library types.
    ///
    /// - Parameters:
    ///   - identifier: The entitlement key identifier string.
    ///   - type: The expected value type.
    ///   - transform: A closure that converts a `PropertyListValue` to the desired type.
    /// - Returns: The entitlement value, or `nil` if not present.
    /// - Throws: An error if the entitlement cannot be read or converted.
    static func getValue<T>(
        for identifier: String,
        as type: T.Type = T.self,
        transform: (PropertyListValue) throws -> T? = { try convertValue($0) }
    ) throws -> T? {
        guard let propertyListValue = try valueForEntitlement(identifier) else {
            return nil
        }
        return try transform(propertyListValue)
    }

    /// Retrieves a RawRepresentable entitlement value using a direct identifier.
    ///
    /// This overload is used for enum types that conform to `RawRepresentable`,
    /// such as `APSEnvironment`. It automatically converts the raw value to the enum case.
    ///
    /// - Parameters:
    ///   - identifier: The entitlement key identifier string.
    ///   - type: The expected enum type.
    ///   - transform: A closure that converts a `PropertyListValue` to the desired enum type.
    /// - Returns: The entitlement value, or `nil` if not present.
    /// - Throws: An error if the entitlement cannot be read or converted.
    static func getValue<T: RawRepresentable>(
        for identifier: String,
        as type: T.Type = T.self,
        transform: (PropertyListValue) throws -> T? = { try convertRawValue($0) }
    ) throws -> T? {
        guard let propertyListValue = try valueForEntitlement(identifier) else {
            return nil
        }
        return try transform(propertyListValue)
    }

    /// Retrieves an array entitlement value using a direct identifier.
    ///
    /// This method is specifically designed for array-type entitlements and converts
    /// `[PropertyListValue]` to the desired array type `[T]`.
    ///
    /// - Parameters:
    ///   - identifier: The entitlement key identifier string.
    ///   - elementType: The expected element type of the array.
    ///   - transform: A closure that converts a `PropertyListValue` to the desired array type.
    /// - Returns: The entitlement array value, or `nil` if not present.
    /// - Throws: An error if the entitlement cannot be read or converted.
    static func getArray<T>(
        for identifier: String,
        elementType: T.Type = T.self,
        transform: (PropertyListValue) throws -> [T]? = { try convertArray($0) }
    ) throws -> [T]? {
        guard let propertyListValue = try valueForEntitlement(identifier) else {
            return nil
        }
        return try transform(propertyListValue)
    }
}

// MARK: - Platform-Specific Implementation

private extension AppEntitlements {
    #if os(macOS)
    static func valueForEntitlement(_ identifier: String) throws -> PropertyListValue? {
        guard let task = SecTaskCreateFromSelf(nil) else {
            throw EntitlementsError.failedToCreateSecurityTask
        }

        var error: Unmanaged<CFError>?
        guard let value = SecTaskCopyValueForEntitlement(task, identifier as CFString, &error) else {
            if let error = error?.takeRetainedValue() {
                throw error
            }
            return nil
        }

        return PropertyListValue(value)
    }
    #else
    static func valueForEntitlement(_ identifier: String) throws -> PropertyListValue? {
        try mainProgramValues.get()[identifier]
    }
    #endif
}

// MARK: - Value Conversion

public extension AppEntitlements {
    /// Converts a PropertyList value to the specified type.
    ///
    /// This is the default conversion method for standard PropertyList types
    /// (String, Bool, Int32, Int64, Float, Double, Date, Data, etc.).
    ///
    /// - Parameters:
    ///   - propertyListValue: The PropertyList value to convert.
    ///   - type: The target type.
    /// - Returns: The converted value, or `nil` if the value is not present.
    /// - Throws: `PropertyListValueError` if the conversion fails.
    static func convertValue<T>(_ propertyListValue: PropertyListValue, to type: T.Type = T.self) throws -> T? {
        try propertyListValue.value(type)
    }

    /// Converts a PropertyList array to an array of the specified element type.
    ///
    /// This method extracts `[PropertyListValue]` from the PropertyList value and
    /// converts each element to type `T`.
    ///
    /// - Parameters:
    ///   - propertyListValue: The PropertyList value containing an array.
    ///   - elementType: The expected element type (used for type inference).
    /// - Returns: The converted array, or `nil` if the value is not an array.
    /// - Throws: `PropertyListValueError` if any element conversion fails.
    static func convertArray<T>(_ propertyListValue: PropertyListValue, elementType: T.Type = T.self) throws -> [T]? {
        guard let array = try propertyListValue.value([PropertyListValue].self) else {
            return nil
        }

        return try array.compactMap { value in
            try value.value(elementType)
        }
    }

    /// Converts a PropertyList value to a RawRepresentable type (typically an enum).
    ///
    /// This method first extracts the raw value from the PropertyList value,
    /// then uses it to initialize the enum case.
    ///
    /// - Parameters:
    ///   - propertyListValue: The PropertyList value containing the raw value.
    ///   - type: The target RawRepresentable type.
    /// - Returns: The enum value, or `nil` if the PropertyList value is not present.
    /// - Throws: `PropertyListValueError.typeMismatch` if the raw value doesn't match any enum case.
    static func convertRawValue<T: RawRepresentable>(_ propertyListValue: PropertyListValue, to type: T.Type = T.self) throws -> T? {
        guard let rawValue = try propertyListValue.value(type.RawValue) else {
            return nil
        }
        guard let enumValue = T(rawValue: rawValue) else {
            throw PropertyListValueError.typeMismatch(expected: type, actual: propertyListValue)
        }
        return enumValue
    }
}
