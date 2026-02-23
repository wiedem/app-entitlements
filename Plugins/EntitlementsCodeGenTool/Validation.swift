private import Foundation

enum ValidationError: Error, CustomStringConvertible {
    case invalidType(property: String, type: String, reason: String)
    case emptyType(property: String)

    var description: String {
        switch self {
        case let .invalidType(property, type, reason):
            "Invalid type '\(type)' for property '\(property)': \(reason)"
        case let .emptyType(property):
            "Empty type for property '\(property)'"
        }
    }
}

enum EntitlementValidator {
    private static let validScalarTypes: Set<String> = ["Bool", "String", "Int", "PropertyListValue"]
    private static let validDictType = "[String: PropertyListValue]"

    static func validate(_ entitlements: EntitlementsData) throws {
        let allProperties = entitlements.properties.ios + entitlements.properties.macOS + entitlements.properties.shared

        for property in allProperties {
            try validatePropertyType(property)
        }
    }

    static func validatePropertyType(_ property: EntitlementProperty) throws {
        let type = property.type.trimmingCharacters(in: .whitespaces)

        guard !type.isEmpty else {
            throw ValidationError.emptyType(property: property.name)
        }

        // Scalar types: Bool, String, Int, PropertyListValue
        if validScalarTypes.contains(type) {
            return
        }

        // Dictionary type: [String: PropertyListValue]
        if type == validDictType {
            return
        }

        // Array types: [T] where T is a valid scalar or dictionary type
        if type.hasPrefix("["), type.hasSuffix("]") {
            let elementType = String(type.dropFirst().dropLast()).trimmingCharacters(in: .whitespaces)

            if validScalarTypes.contains(elementType) || elementType == validDictType {
                return
            }
        }

        throw ValidationError.invalidType(
            property: property.name,
            type: type,
            reason: "Type must be one of: Bool, String, Int, PropertyListValue, [String: PropertyListValue], or an array of these types"
        )
    }
}
