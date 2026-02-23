import Testing
@testable import entitlements_codegen_tool

@Suite("CodeGenerator Tests")
struct CodeGeneratorTests {

    // MARK: - Test Data

    let sampleEntitlements = EntitlementsData(
        version: "1.0",
        properties: .init(
            ios: [
                EntitlementProperty(
                    name: "testEntitlement",
                    entitlementKey: "testEntitlement",
                    rawKey: "com.apple.test",
                    type: "String",
                    possibleValues: nil,
                    category: "Testing",
                    documentation: "A test entitlement",
                    appleDocUrl: "https://developer.apple.com/test",
                    availability: [
                        Availability(platform: "iOS", introducedAt: "15.0", unavailable: false)
                    ]
                ),
                EntitlementProperty(
                    name: "arrayEntitlement",
                    entitlementKey: "arrayEntitlement",
                    rawKey: "com.apple.array-test",
                    type: "[String]",
                    possibleValues: nil,
                    category: "Testing",
                    documentation: "An array entitlement",
                    appleDocUrl: "https://developer.apple.com/array-test",
                    availability: [
                        Availability(platform: "iOS", introducedAt: "16.0", unavailable: false)
                    ]
                ),
                EntitlementProperty(
                    name: "uncategorizedEntitlement",
                    entitlementKey: "uncategorizedEntitlement",
                    rawKey: "com.apple.uncategorized",
                    type: "Bool",
                    possibleValues: nil,
                    category: nil,
                    documentation: "Entitlement without category",
                    appleDocUrl: "https://developer.apple.com/uncategorized",
                    availability: [
                        Availability(platform: "iOS", introducedAt: "15.0", unavailable: false)
                    ]
                )
            ],
            macOS: [],
            shared: []
        )
    )

    let sampleTypeMappings = TypeMappingsData(
        version: "1.0",
        enums: [
            EnumDefinition(
                name: "TestEnum",
                propertyName: "testEnumProperty",
                rawValueType: "String",
                documentation: "A test enum",
                cases: [
                    EnumCase(name: "case1", rawValue: "value1", documentation: "First case"),
                    EnumCase(name: "case2", rawValue: "value2", documentation: nil)
                ]
            )
        ]
    )

    // MARK: - Entitlement Enum Generation Tests

    @Test("Generate entitlement enum with categories")
    func testGenerateEntitlementEnum() {
        let generator = CodeGenerator(entitlements: sampleEntitlements, typeMappings: sampleTypeMappings)
        let output = generator.generateEntitlementEnum()

        #expect(output.contains("public enum Entitlement: String, Sendable"))
        #expect(output.contains("// MARK: - Testing"))
        #expect(output.contains("// MARK: - Uncategorized"))
        #expect(output.contains("case testEntitlement = \"com.apple.test\""))
        #expect(output.contains("case arrayEntitlement = \"com.apple.array-test\""))
        #expect(output.contains("case uncategorizedEntitlement = \"com.apple.uncategorized\""))
    }

    @Test("Generate entitlement enum with documentation")
    func testGenerateEntitlementEnumWithDocumentation() {
        let generator = CodeGenerator(entitlements: sampleEntitlements, typeMappings: sampleTypeMappings)
        let output = generator.generateEntitlementEnum()

        #expect(output.contains("/// A test entitlement"))
        #expect(output.contains("/// - SeeAlso: [A test entitlement](https://developer.apple.com/test)"))
    }

    @Test("Generate entitlement enum with availability attributes")
    func testGenerateEntitlementEnumWithAvailability() {
        let generator = CodeGenerator(entitlements: sampleEntitlements, typeMappings: sampleTypeMappings)
        let output = generator.generateEntitlementEnum()

        #expect(output.contains("@available(iOS 15.0, *)"))
        #expect(output.contains("@available(iOS 16.0, *)"))
    }

    // MARK: - Value Types Generation Tests

    @Test("Generate value types enum")
    func testGenerateValueTypes() {
        let generator = CodeGenerator(entitlements: sampleEntitlements, typeMappings: sampleTypeMappings)
        let output = generator.generateValueTypes()

        #expect(output.contains("/// A test enum"))
        #expect(output.contains("public enum TestEnum: String, Sendable"))
        #expect(output.contains("/// First case"))
        #expect(output.contains("case case1 = \"value1\""))
        #expect(output.contains("case case2 = \"value2\""))
    }

    @Test("Generate value types with optional documentation")
    func testGenerateValueTypesWithOptionalDocumentation() {
        let generator = CodeGenerator(entitlements: sampleEntitlements, typeMappings: sampleTypeMappings)
        let output = generator.generateValueTypes()

        // case1 has documentation
        #expect(output.contains("/// First case\n    case case1"))

        // case2 has no documentation, should not have doc comment
        let case2Lines = output.components(separatedBy: "\n").filter { $0.contains("case case2") }
        #expect(case2Lines.count == 1)
    }

    // MARK: - Property File Generation Tests

    @Test("Generate property file with string property")
    func testGeneratePropertyFileWithStringProperty() {
        let generator = CodeGenerator(entitlements: sampleEntitlements, typeMappings: sampleTypeMappings)
        let output = generator.generatePropertyFile(for: "iOS", properties: sampleEntitlements.properties.ios)

        #expect(output.contains("internal import Foundation"))
        #expect(output.contains("static var testEntitlement: String?"))
        #expect(output.contains("try AppEntitlements.getValue(for: Entitlement.testEntitlement, as: String.self)"))
    }

    @Test("Generate property file with array property")
    func testGeneratePropertyFileWithArrayProperty() {
        let generator = CodeGenerator(entitlements: sampleEntitlements, typeMappings: sampleTypeMappings)
        let output = generator.generatePropertyFile(for: "iOS", properties: sampleEntitlements.properties.ios)

        #expect(output.contains("static var arrayEntitlement: [String]?"))
        #expect(output.contains("try AppEntitlements.getArray(for: Entitlement.arrayEntitlement, elementType: String.self)"))
    }

    @Test("Generate property file with bool property")
    func testGeneratePropertyFileWithBoolProperty() {
        let generator = CodeGenerator(entitlements: sampleEntitlements, typeMappings: sampleTypeMappings)
        let output = generator.generatePropertyFile(for: "iOS", properties: sampleEntitlements.properties.ios)

        #expect(output.contains("static var uncategorizedEntitlement: Bool?"))
        #expect(output.contains("try AppEntitlements.getValue(for: Entitlement.uncategorizedEntitlement, as: Bool.self)"))
    }

    @Test("Generate property file with categories")
    func testGeneratePropertyFileWithCategories() {
        let generator = CodeGenerator(entitlements: sampleEntitlements, typeMappings: sampleTypeMappings)
        let output = generator.generatePropertyFile(for: "iOS", properties: sampleEntitlements.properties.ios)

        #expect(output.contains("// MARK: - Testing"))
        #expect(output.contains("// MARK: - Uncategorized"))
    }

    @Test("Generate property file with availability groups")
    func testGeneratePropertyFileWithAvailabilityGroups() {
        let generator = CodeGenerator(entitlements: sampleEntitlements, typeMappings: sampleTypeMappings)
        let output = generator.generatePropertyFile(for: "iOS", properties: sampleEntitlements.properties.ios)

        #expect(output.contains("@available(iOS 15.0, *)"))
        #expect(output.contains("@available(iOS 16.0, *)"))
        #expect(output.contains("public extension AppEntitlements"))
    }

    // MARK: - Edge Cases

    @Test("Handle properties without category")
    func testHandlePropertiesWithoutCategory() {
        let generator = CodeGenerator(entitlements: sampleEntitlements, typeMappings: sampleTypeMappings)
        let output = generator.generatePropertyFile(for: "iOS", properties: sampleEntitlements.properties.ios)

        #expect(output.contains("// MARK: - Uncategorized"))
        #expect(output.contains("uncategorizedEntitlement"))
    }

    @Test("Generate proper throwing getters")
    func testGenerateProperThrowingGetters() {
        let generator = CodeGenerator(entitlements: sampleEntitlements, typeMappings: sampleTypeMappings)
        let output = generator.generatePropertyFile(for: "iOS", properties: sampleEntitlements.properties.ios)

        #expect(output.contains("get throws {"))
        #expect(output.contains("try AppEntitlements.getValue"))
        #expect(output.contains("try AppEntitlements.getArray"))
    }

    @Test("Generate enum type mapping")
    func testGenerateEnumTypeMapping() {
        let customEntitlements = EntitlementsData(
            version: "1.0",
            properties: .init(
                ios: [
                    EntitlementProperty(
                        name: "testEnumProperty",
                        entitlementKey: "testEnumProperty",
                        rawKey: "com.apple.test-enum",
                        type: "String",
                        possibleValues: ["value1", "value2"],
                        category: "Testing",
                        documentation: "Test enum property",
                        appleDocUrl: "https://developer.apple.com/test-enum",
                        availability: [
                            Availability(platform: "iOS", introducedAt: "15.0", unavailable: false)
                        ]
                    )
                ],
                macOS: [],
                shared: []
            )
        )

        let generator = CodeGenerator(entitlements: customEntitlements, typeMappings: sampleTypeMappings)
        let output = generator.generatePropertyFile(for: "iOS", properties: customEntitlements.properties.ios)

        // Should use TestEnum type instead of String
        #expect(output.contains("static var testEnumProperty: TestEnum?"))
        #expect(output.contains("try AppEntitlements.getValue(for: Entitlement.testEnumProperty, as: TestEnum.self)"))
    }
}
