@testable import entitlements_codegen_tool
import Testing

@Suite("Type Validation Tests")
struct ValidationTests {
    // MARK: - Valid Types

    @Test("Valid types", arguments: [
        "Bool",
        "String",
        "Int",
        "PropertyListValue",
        "[String: PropertyListValue]",
        "[Bool]",
        "[String]",
        "[Int]",
        "[PropertyListValue]",
        "[[String: PropertyListValue]]",
    ])
    func validTypes(type: String) throws {
        let property = createProperty(type: type)
        let entitlements = createEntitlements(with: [property])

        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }

    // MARK: - Whitespace Handling

    @Test("Valid types with whitespace", arguments: [
        "   Bool   ",
        "[   String   ]",
    ])
    func validTypesWithWhitespace(type: String) throws {
        let property = createProperty(type: type)
        let entitlements = createEntitlements(with: [property])

        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }

    @Test("Invalid type: only whitespace")
    func invalidTypeOnlyWhitespace() throws {
        let property = createProperty(type: "    ")
        let entitlements = createEntitlements(with: [property])

        #expect(throws: ValidationError.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }

    // MARK: - Invalid Types

    @Test("Invalid types", arguments: [
        "",
        "String?",
        "[String]?",
        "UnknownType",
        "Int32",
        "Double",
        "[[String]]",
        "[UnknownType]",
    ])
    func invalidTypes(type: String) throws {
        let property = createProperty(type: type)
        let entitlements = createEntitlements(with: [property])

        #expect(throws: ValidationError.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
}

// MARK: - Helper Methods

private extension ValidationTests {
    func createProperty(type: String) -> EntitlementProperty {
        EntitlementProperty(
            name: "testProperty",
            entitlementKey: "testProperty",
            rawKey: "com.test.property",
            type: type,
            possibleValues: nil,
            category: "Test",
            documentation: "Test property",
            appleDocUrl: "https://example.com",
            availability: []
        )
    }

    func createEntitlements(with properties: [EntitlementProperty]) -> EntitlementsData {
        EntitlementsData(
            version: "1.0",
            properties: .init(ios: properties, macOS: [], shared: []),
            supportedPlatforms: [
                SupportedPlatform(name: "iOS", version: "15.0"),
                SupportedPlatform(name: "macOS", version: "12.0"),
                SupportedPlatform(name: "tvOS", version: "15.0"),
                SupportedPlatform(name: "visionOS", version: "1.0"),
                SupportedPlatform(name: "watchOS", version: "8.0"),
            ]
        )
    }
}
