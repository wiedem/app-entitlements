private import Foundation

struct CodeGenerator {
    let entitlements: EntitlementsData
    let typeMappings: TypeMappingsData
    let excludedProperties: Set<String>

    // MARK: - Entitlement.swift Generation

    func generateEntitlementEnumFile() -> String {
        var output = """
        /// All known app entitlement keys.
        ///
        /// This enum provides type-safe access to entitlement identifiers used across Apple platforms.
        public enum Entitlement: String, Sendable {

        """

        // Collect all properties grouped by category, filtering out excluded properties
        let allProperties = (entitlements.properties.ios + entitlements.properties.macOS + entitlements.properties.shared)
            .filter { !excludedProperties.contains($0.name) }
        let grouped = Dictionary(grouping: allProperties) { $0.category ?? "Uncategorized" }
        let sortedCategories = grouped.keys.sorted()

        for (index, category) in sortedCategories.enumerated() {
            // Add blank line before each category excepet the first one
            if index > 0 {
                output += "\n"
            }

            let properties = grouped[category]!.sorted { $0.name < $1.name }

            output += "    // MARK: - \(category)\n"

            for property in properties {
                // Add blank line before each property
                output += "\n"

                // Generate DocC comment
                output += "    /// \(property.documentation)\n"
                output += "    ///\n"
                output += "    /// - SeeAlso: [\(property.documentation)](\(property.appleDocUrl))\n"

                // Generate @available attributes based on platform availability
                let availabilityAttrs = generateAvailabilityAttributes(property.availability)
                for attr in availabilityAttrs {
                    output += "    \(attr)\n"
                }

                output += "    case \(property.name) = \"\(property.rawKey)\"\n"
            }
        }

        output += "}\n"

        return output
    }

    // MARK: - EntitlementValueTypes.swift Generation

    func generateValueTypesFile() -> String {
        var output = ""

        for (index, enumDef) in typeMappings.enums.enumerated() {
            // Add blank line before enum (except the first one)
            if index > 0 {
                output += "\n"
            }
            
            // Generate enum documentation
            output += "/// \(enumDef.documentation)\n"
            output += "public enum \(enumDef.name): \(enumDef.rawValueType), Sendable {\n"

            for enumCase in enumDef.cases {
                if let doc = enumCase.documentation {
                    output += "    /// \(doc)\n"
                }
                output += "    case \(enumCase.name) = \"\(enumCase.rawValue)\"\n"
            }

            output += "}\n"
        }

        return output
    }

    // MARK: - Platform-Specific Property Files Generation

    func generatePropertyFile(for platform: String, properties: [EntitlementProperty]) -> String {
        // Filter out excluded properties
        let filteredProperties = properties.filter { !excludedProperties.contains($0.name) }

        // Check if any property uses Data type (requires public import)
        let needsPublicImport = filteredProperties.contains { property in
            property.type == "Data" || property.type == "[Data]"
        }

        // Always use public import AppEntitlements for the Catalog target
        var output = "public import AppEntitlements\n"

        // Add Foundation import if needed
        let foundationImport = needsPublicImport ? "public import Foundation\n" : "internal import Foundation\n"
        output += foundationImport

        // Find custom enum type for each property
        let enumMappings = Dictionary(uniqueKeysWithValues: typeMappings.enums.map { ($0.propertyName, $0.name) })

        // Group by category using filtered properties
        let grouped = Dictionary(grouping: filteredProperties) { $0.category ?? "Uncategorized" }
        let sortedCategories = grouped.keys.sorted()

        for category in sortedCategories {
            let categoryProperties = grouped[category]!.sorted { $0.name < $1.name }

            output += "\n// MARK: - \(category)\n\n"

            // Group properties by availability to create minimal extension scopes
            let availabilityGroups = Dictionary(grouping: categoryProperties) { property -> String in
                generateAvailabilityAttributeString(property.availability)
            }
            
            let sortedGroups = availabilityGroups.sorted(by: { $0.key < $1.key })

            for (groupIndex, (availabilityAttr, groupProperties)) in sortedGroups.enumerated() {
                if !availabilityAttr.isEmpty {
                    output += availabilityAttr + "\n"
                }
                output += "public extension AppEntitlements {\n"

                let sortedProperties = groupProperties.sorted(by: { $0.name < $1.name })
                for (propertyIndex, property) in sortedProperties.enumerated() {
                    // Generate DocC comment
                    output += "    /// \(property.documentation)\n"
                    output += "    ///\n"
                    output += "    /// - SeeAlso: [\(property.documentation)](\(property.appleDocUrl))\n"

                    // Determine property type and getter implementation
                    let (propertyType, getterBody) = generatePropertyTypeAndGetter(property: property, enumMappings: enumMappings)

                    output += "    static var \(property.name): \(propertyType) {\n"
                    output += "        \(getterBody)\n"
                    output += "    }\n"

                    // Add blank line between properties within the same extension
                    if propertyIndex < sortedProperties.count - 1 {
                        output += "\n"
                    }
                }

                output += "}\n"
                
                // Add blank line between extensions (but not after the last one in any category)
                let isLastGroup = groupIndex == sortedGroups.count - 1
                if !isLastGroup {
                    output += "\n"
                }
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
        generateAvailabilityAttributes(availability).joined(separator: "\n")
    }

    func generateAvailabilityAttributes(_ availability: [Availability]) -> [String] {
        var attributes: [String] = []

        // Filter out redundant availability that matches or is below package minimum versions
        let filteredAvailability = filterRedundantAvailability(availability)

        // Group by introduced and unavailable
        let introduced = filteredAvailability.filter { $0.unavailable != true }
        let unavailable = filteredAvailability.filter { $0.unavailable == true }

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

    // MARK: - Availability Filtering

    /// Filters out availability attributes that match or are below the package's minimum deployment versions.
    /// Also filters out platforms that are not in the package's supportedPlatforms list.
    func filterRedundantAvailability(_ availability: [Availability]) -> [Availability] {
        // Build a set of supported platform names
        let supportedPlatformNames = Set(entitlements.supportedPlatforms.map { $0.name.lowercased() })
        
        // Build a lookup dictionary from supportedPlatforms
        let minimumVersions = Dictionary(
            uniqueKeysWithValues: entitlements.supportedPlatforms.map { ($0.name.lowercased(), $0.version) }
        )

        return availability.filter { av in
            guard av.unavailable != true else { return false }
            
            let platformName = av.platform.lowercased()
            
            // Filter out platforms that are not in supportedPlatforms
            guard supportedPlatformNames.contains(platformName) else {
                return false
            }

            // Filter out versions that match or are below the package minimum
            guard let minimumVersion = minimumVersions[platformName] else {
                return true
            }

            return isVersion(av.introducedAt, greaterThan: minimumVersion)
        }
    }

}

// MARK: - Version Comparison

extension CodeGenerator {
    /// Compares two version strings (e.g., "15.0" vs "14.0").
    /// Returns true if `version` is greater than `baseline`.
    func isVersion(_ version: String, greaterThan baseline: String) -> Bool {
        let versionComponents = version.split(separator: ".").compactMap { Int($0) }
        let baselineComponents = baseline.split(separator: ".").compactMap { Int($0) }

        for (v, b) in zip(versionComponents, baselineComponents) {
            if v > b { return true }
            if v < b { return false }
        }

        // If all components match, check if version has more components
        return versionComponents.count > baselineComponents.count
    }
}
