private import Foundation

struct CodeGenerator {
    let entitlements: EntitlementsData
    let typeMappings: TypeMappingsData

    // MARK: - Entitlement.swift Generation

    func generateEntitlementEnum() -> String {
        var output = """
        /// All known app entitlement keys.
        ///
        /// This enum provides type-safe access to entitlement identifiers used across Apple platforms.
        public enum Entitlement: String, Sendable {

        """

        // Collect all properties grouped by category
        let allProperties = entitlements.properties.ios + entitlements.properties.macOS + entitlements.properties.shared
        let grouped = Dictionary(grouping: allProperties) { $0.category ?? "Uncategorized" }
        let sortedCategories = grouped.keys.sorted()

        for category in sortedCategories {
            let properties = grouped[category]!.sorted { $0.name < $1.name }

            output += "    // MARK: - \(category)\n\n"

            for property in properties {
                // Generate DocC comment
                output += "    /// \(property.documentation)\n"
                output += "    ///\n"
                output += "    /// - SeeAlso: [\(property.documentation)](\(property.appleDocUrl))\n"

                // Generate @available attributes based on platform availability
                let availabilityAttrs = generateAvailabilityAttributes(property.availability)
                for attr in availabilityAttrs {
                    output += "    \(attr)\n"
                }

                output += "    case \(property.name) = \"\(property.rawKey)\"\n\n"
            }
        }

        output += "}\n"

        return output
    }

    // MARK: - EntitlementValueTypes.swift Generation

    func generateValueTypes() -> String {
        var output = ""

        for enumDef in typeMappings.enums {
            // Generate enum documentation
            output += "/// \(enumDef.documentation)\n"
            output += "public enum \(enumDef.name): \(enumDef.rawValueType), Sendable {\n"

            for enumCase in enumDef.cases {
                if let doc = enumCase.documentation {
                    output += "    /// \(doc)\n"
                }
                output += "    case \(enumCase.name) = \"\(enumCase.rawValue)\"\n"
            }

            output += "}\n\n"
        }

        return output
    }

    // MARK: - Platform-Specific Property Files Generation

    func generatePropertyFile(for platform: String, properties: [EntitlementProperty]) -> String {
        var output = """
        internal import Foundation

        """

        // Find custom enum type for each property
        let enumMappings = Dictionary(uniqueKeysWithValues: typeMappings.enums.map { ($0.propertyName, $0.name) })

        // Group by category
        let grouped = Dictionary(grouping: properties) { $0.category ?? "Uncategorized" }
        let sortedCategories = grouped.keys.sorted()

        for category in sortedCategories {
            let categoryProperties = grouped[category]!.sorted { $0.name < $1.name }

            output += "// MARK: - \(category)\n\n"

            // Group properties by availability to create minimal extension scopes
            let availabilityGroups = Dictionary(grouping: categoryProperties) { property -> String in
                generateAvailabilityAttributeString(property.availability)
            }

            for (availabilityAttr, groupProperties) in availabilityGroups.sorted(by: { $0.key < $1.key }) {
                if !availabilityAttr.isEmpty {
                    output += availabilityAttr + "\n"
                }
                output += "public extension AppEntitlements {\n"

                for property in groupProperties.sorted(by: { $0.name < $1.name }) {
                    // Generate DocC comment
                    output += "    /// \(property.documentation)\n"
                    output += "    ///\n"
                    output += "    /// - SeeAlso: [\(property.documentation)](\(property.appleDocUrl))\n"

                    // Determine property type and getter implementation
                    let (propertyType, getterBody) = generatePropertyTypeAndGetter(property: property, enumMappings: enumMappings)

                    output += "    static var \(property.name): \(propertyType) {\n"
                    output += "        \(getterBody)\n"
                    output += "    }\n"

                    if property != groupProperties.last {
                        output += "\n"
                    }
                }

                output += "}\n\n"
            }
        }

        return output
    }
}

// MARK: - Private Helpers

private extension CodeGenerator {
    func generatePropertyTypeAndGetter(property: EntitlementProperty, enumMappings: [String: String]) -> (type: String, getter: String) {
        // Determine if it's an array type
        if property.type.hasPrefix("[") {
            // For array types, check if there's a custom enum mapping
            let elementType: String
            let propertyType: String
            
            if let enumType = enumMappings[property.name] {
                // Custom enum type for array elements
                elementType = enumType
                propertyType = "[\(enumType)]?"
            } else {
                // Standard array type - extract element type between [ and ]
                let startIndex = property.type.index(after: property.type.startIndex)
                let endIndex = property.type.index(before: property.type.endIndex)
                elementType = String(property.type[startIndex..<endIndex])
                // Add ? to make it optional
                propertyType = "\(property.type)?"
            }
            
            let getter: String
            if enumMappings[property.name] != nil {
                // For enum arrays, we don't need to specify elementType explicitly
                getter = "get throws {\n            try AppEntitlements.getArray(for: Entitlement.\(property.name))\n        }"
            } else {
                getter = "get throws {\n            try AppEntitlements.getArray(for: Entitlement.\(property.name), elementType: \(elementType).self)\n        }"
            }
            return (propertyType, getter)
        } else {
            // Non-array type
            // Check if there's a custom enum type for this property
            let valueType: String
            if let enumType = enumMappings[property.name] {
                valueType = enumType
            } else {
                valueType = property.type
            }

            // Add ? to make it optional
            let propertyType = "\(valueType)?"
            let getter = "get throws {\n            try AppEntitlements.getValue(for: Entitlement.\(property.name), as: \(valueType).self)\n        }"
            return (propertyType, getter)
        }
    }

    func generateAvailabilityAttributeString(_ availability: [Availability]) -> String {
        let introduced = availability.filter { $0.unavailable != true }
        let unavailable = availability.filter { $0.unavailable == true }

        var attrs: [String] = []

        if !introduced.isEmpty {
            let platforms = introduced.map { platformAvailability($0) }.joined(separator: ", ")
            attrs.append("@available(\(platforms), *)")
        }

        for unavail in unavailable {
            let platformName = mapPlatformName(unavail.platform)
            attrs.append("@available(\(platformName), unavailable)")
        }

        return attrs.joined(separator: "\n")
    }

    func generateAvailabilityAttributes(_ availability: [Availability]) -> [String] {
        var attributes: [String] = []

        // Group by introduced and unavailable
        let introduced = availability.filter { $0.unavailable != true }
        let unavailable = availability.filter { $0.unavailable == true }

        if !introduced.isEmpty {
            let platforms = introduced.map { platformAvailability($0) }.joined(separator: ", ")
            attributes.append("@available(\(platforms), *)")
        }

        for unavail in unavailable {
            let platformName = mapPlatformName(unavail.platform)
            attributes.append("@available(\(platformName), unavailable)")
        }

        return attributes
    }

    func platformAvailability(_ availability: Availability) -> String {
        let platformName = mapPlatformName(availability.platform)
        return "\(platformName) \(availability.introducedAt)"
    }

    func mapPlatformName(_ platform: String) -> String {
        switch platform.lowercased() {
        case "ios": "iOS"
        case "macos": "macOS"
        case "tvos": "tvOS"
        case "watchos": "watchOS"
        case "visionos": "visionOS"
        default: platform
        }
    }
}
