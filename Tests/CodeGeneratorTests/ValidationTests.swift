import Testing
@testable import entitlements_codegen_tool

@Suite("Type Validation Tests")
struct ValidationTests {
    
    // MARK: - Valid Types
    
    @Test("Valid type: Bool")
    func testValidTypeBool() throws {
        let property = EntitlementProperty(
            name: "testBool",
            entitlementKey: "testBool",
            rawKey: "com.test.bool",
            type: "Bool",
            possibleValues: nil,
            category: "Test",
            documentation: "Test",
            appleDocUrl: "https://example.com",
            availability: []
        )
        
        let entitlements = EntitlementsData(
            version: "1.0",
            properties: .init(ios: [property], macOS: [], shared: [])
        )
        
        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Valid type: String")
    func testValidTypeString() throws {
        let property = createProperty(type: "String")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Valid type: Int")
    func testValidTypeInt() throws {
        let property = createProperty(type: "Int")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Valid type: PropertyListValue")
    func testValidTypePropertyListValue() throws {
        let property = createProperty(type: "PropertyListValue")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Valid type: [String: PropertyListValue]")
    func testValidTypeDictionary() throws {
        let property = createProperty(type: "[String: PropertyListValue]")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Valid type: [Bool]")
    func testValidTypeArrayBool() throws {
        let property = createProperty(type: "[Bool]")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Valid type: [String]")
    func testValidTypeArrayString() throws {
        let property = createProperty(type: "[String]")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Valid type: [Int]")
    func testValidTypeArrayInt() throws {
        let property = createProperty(type: "[Int]")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Valid type: [PropertyListValue]")
    func testValidTypeArrayPropertyListValue() throws {
        let property = createProperty(type: "[PropertyListValue]")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Valid type: [[String: PropertyListValue]]")
    func testValidTypeArrayDictionary() throws {
        let property = createProperty(type: "[[String: PropertyListValue]]")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    // MARK: - Whitespace Handling
    
    @Test("Valid type with leading/trailing whitespace: Bool")
    func testValidTypeWithWhitespace() throws {
        let property = createProperty(type: "   Bool   ")
        let entitlements = createEntitlements(with: [property])
        
        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Valid array type with whitespace: [String]")
    func testValidArrayTypeWithWhitespace() throws {
        let property = createProperty(type: "[   String   ]")
        let entitlements = createEntitlements(with: [property])
        
        #expect(throws: Never.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Invalid type: only whitespace")
    func testInvalidTypeOnlyWhitespace() throws {
        let property = createProperty(type: "    ")
        let entitlements = createEntitlements(with: [property])
        
        #expect(throws: ValidationError.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    // MARK: - Invalid Types
    
    @Test("Invalid type: empty string")
    func testInvalidTypeEmpty() throws {
        let property = createProperty(type: "")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: ValidationError.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Invalid type: with optional")
    func testInvalidTypeWithOptional() throws {
        let property = createProperty(type: "String?")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: ValidationError.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Invalid type: array with optional")
    func testInvalidTypeArrayWithOptional() throws {
        let property = createProperty(type: "[String]?")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: ValidationError.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Invalid type: unknown type")
    func testInvalidTypeUnknown() throws {
        let property = createProperty(type: "UnknownType")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: ValidationError.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Invalid type: unsupported Int32")
    func testInvalidTypeInt32() throws {
        let property = createProperty(type: "Int32")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: ValidationError.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Invalid type: unsupported Double")
    func testInvalidTypeDouble() throws {
        let property = createProperty(type: "Double")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: ValidationError.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Invalid type: nested array")
    func testInvalidTypeNestedArray() throws {
        let property = createProperty(type: "[[String]]")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: ValidationError.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    @Test("Invalid type: unsupported array element")
    func testInvalidTypeArrayUnknown() throws {
        let property = createProperty(type: "[UnknownType]")
        let entitlements = createEntitlements(with: [property])
        #expect(throws: ValidationError.self) {
            try EntitlementValidator.validate(entitlements)
        }
    }
    
    // MARK: - Helper Methods
    
    private func createProperty(type: String) -> EntitlementProperty {
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
    
    private func createEntitlements(with properties: [EntitlementProperty]) -> EntitlementsData {
        EntitlementsData(
            version: "1.0",
            properties: .init(ios: properties, macOS: [], shared: [])
        )
    }
}
