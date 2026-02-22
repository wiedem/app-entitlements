public import AppEntitlementsCore

public extension AppEntitlements {
    /// Retrieves an entitlement value using a type-safe identifier.
    ///
    /// This method accepts any type conforming to `EntitlementIdentifying`,
    /// providing compile-time safety for entitlement keys.
    ///
    /// - Parameters:
    ///   - identifier: A type-safe entitlement identifier.
    ///   - type: The expected value type.
    ///   - transform: A closure that converts a `PropertyListValue` to the desired type.
    /// - Returns: The entitlement value, or `nil` if not present.
    /// - Throws: An error if the entitlement cannot be read or converted.
    static func getValue<T>(
        for identifier: some EntitlementIdentifying,
        as type: T.Type = T.self,
        transform: (PropertyListValue) throws -> T? = { try convertValue($0) }
    ) throws -> T? {
        try getValue(
            for: identifier.entitlementID,
            as: type,
            transform: transform
        )
    }

    /// Retrieves a RawRepresentable entitlement value using a type-safe identifier.
    ///
    /// This overload is used for enum types that conform to `RawRepresentable`.
    /// It automatically converts the raw value to the enum case.
    ///
    /// - Parameters:
    ///   - identifier: A type-safe entitlement identifier.
    ///   - type: The expected enum type.
    ///   - transform: A closure that converts a `PropertyListValue` to the desired enum type.
    /// - Returns: The entitlement value, or `nil` if not present.
    /// - Throws: An error if the entitlement cannot be read or converted.
    static func getValue<T: RawRepresentable>(
        for identifier: some EntitlementIdentifying,
        as type: T.Type = T.self,
        transform: (PropertyListValue) throws -> T? = { try convertRawValue($0) }
    ) throws -> T? {
        try getValue(
            for: identifier.entitlementID,
            as: type,
            transform: transform
        )
    }

    /// Retrieves an array entitlement value using a type-safe identifier.
    ///
    /// This method is specifically designed for array-type entitlements and converts
    /// `[PropertyListValue]` to the desired array type `[T]`.
    ///
    /// - Parameters:
    ///   - identifier: A type-safe entitlement identifier.
    ///   - elementType: The expected element type of the array.
    ///   - transform: A closure that converts a `PropertyListValue` to the desired array type.
    /// - Returns: The entitlement array value, or `nil` if not present.
    /// - Throws: An error if the entitlement cannot be read or converted.
    static func getArray<T>(
        for identifier: some EntitlementIdentifying,
        elementType: T.Type = T.self,
        transform: (PropertyListValue) throws -> [T]? = { try convertArray($0) }
    ) throws -> [T]? {
        try getArray(
            for: identifier.entitlementID,
            elementType: elementType,
            transform: transform
        )
    }
}
