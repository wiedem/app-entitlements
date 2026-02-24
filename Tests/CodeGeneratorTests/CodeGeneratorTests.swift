@testable import entitlements_codegen_tool
import Testing

@Suite("CodeGenerator Tests")
struct CodeGeneratorTests {
    // MARK: - Entitlement Enum File Generation Tests

    @Test("Generate complete Entitlement.swift file")
    func generateEntitlementEnumFile() {
        let generator = CodeGenerator(
            entitlements: Self.sampleEntitlements,
            typeMappings: Self.sampleTypeMappings,
            excludedProperties: []
        )
        let output = generator.generateEntitlementEnumFile()

        let expected = """
        /// All known app entitlement keys.
        ///
        /// This enum provides type-safe access to entitlement identifiers used across Apple platforms.
        public enum Entitlement: String, Sendable {
            // MARK: - Testing

            /// An array entitlement
            ///
            /// - SeeAlso: [An array entitlement](https://developer.apple.com/array-test)
            @available(iOS 16.0, *)
            case arrayEntitlement = "com.apple.array-test"

            /// A test entitlement
            ///
            /// - SeeAlso: [A test entitlement](https://developer.apple.com/test)
            case testEntitlement = "com.apple.test"

            // MARK: - Uncategorized

            /// Entitlement without category
            ///
            /// - SeeAlso: [Entitlement without category](https://developer.apple.com/uncategorized)
            case uncategorizedEntitlement = "com.apple.uncategorized"
        }

        """

        #expect(output == expected)
    }

    // MARK: - Value Types File Generation Tests

    @Test("Generate complete EntitlementValueTypes.swift file")
    func generateValueTypesFile() {
        let generator = CodeGenerator(
            entitlements: Self.sampleEntitlements,
            typeMappings: Self.sampleTypeMappings,
            excludedProperties: []
        )
        let output = generator.generateValueTypesFile()

        let expected = """
        /// A test enum
        public enum TestEnum: String, Sendable {
            /// First case
            case case1 = "value1"
            case case2 = "value2"
        }

        """

        #expect(output == expected)
    }

    // MARK: - Platform-Specific Property File Generation Tests

    @Test("Generate complete AppEntitlements+iOS.swift file")
    func generatePropertyFileForIOS() {
        let generator = CodeGenerator(
            entitlements: Self.sampleEntitlements,
            typeMappings: Self.sampleTypeMappings,
            excludedProperties: []
        )
        let output = generator.generatePropertyFile(
            for: "iOS",
            properties: Self.sampleEntitlements.properties.ios
        )

        let expected = """
        public import AppEntitlements
        internal import Foundation

        // MARK: - Testing

        public extension AppEntitlements {
            /// A test entitlement
            ///
            /// - SeeAlso: [A test entitlement](https://developer.apple.com/test)
            static var testEntitlement: String? {
                get throws {
                    try AppEntitlements.getValue(for: Entitlement.testEntitlement, as: String.self)
                }
            }
        }

        @available(iOS 16.0, *)
        public extension AppEntitlements {
            /// An array entitlement
            ///
            /// - SeeAlso: [An array entitlement](https://developer.apple.com/array-test)
            static var arrayEntitlement: [String]? {
                get throws {
                    try AppEntitlements.getArray(for: Entitlement.arrayEntitlement, elementType: String.self)
                }
            }
        }

        // MARK: - Uncategorized

        public extension AppEntitlements {
            /// Entitlement without category
            ///
            /// - SeeAlso: [Entitlement without category](https://developer.apple.com/uncategorized)
            static var uncategorizedEntitlement: Bool? {
                get throws {
                    try AppEntitlements.getValue(for: Entitlement.uncategorizedEntitlement, as: Bool.self)
                }
            }
        }

        """

        #expect(output == expected)
    }

    @Test("Generate property file with Data type requiring public import")
    func generatePropertyFileWithDataType() {
        let dataEntitlements = EntitlementsData(
            version: "1.0",
            properties: .init(
                ios: [
                    EntitlementProperty(
                        name: "dataProperty",
                        entitlementKey: "dataProperty",
                        rawKey: "com.apple.test-data",
                        type: "Data",
                        possibleValues: nil,
                        category: "Testing",
                        documentation: "Test data property",
                        appleDocUrl: "https://developer.apple.com/test-data",
                        availability: [
                            Availability(platform: "iOS", introducedAt: "15.0", unavailable: false),
                        ]
                    ),
                ],
                macOS: [],
                shared: []
            ),
            supportedPlatforms: Self.sampleEntitlements.supportedPlatforms
        )

        let generator = CodeGenerator(
            entitlements: dataEntitlements,
            typeMappings: Self.sampleTypeMappings,
            excludedProperties: []
        )
        let output = generator.generatePropertyFile(
            for: "iOS",
            properties: dataEntitlements.properties.ios
        )

        let expected = """
        public import AppEntitlements
        public import Foundation

        // MARK: - Testing

        public extension AppEntitlements {
            /// Test data property
            ///
            /// - SeeAlso: [Test data property](https://developer.apple.com/test-data)
            static var dataProperty: Data? {
                get throws {
                    try AppEntitlements.getValue(for: Entitlement.dataProperty, as: Data.self)
                }
            }
        }

        """

        #expect(output == expected)
    }

    @Test("Generate property file with custom enum type mapping")
    func generatePropertyFileWithEnumTypeMapping() {
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
                            Availability(platform: "iOS", introducedAt: "15.0", unavailable: false),
                        ]
                    ),
                ],
                macOS: [],
                shared: []
            ),
            supportedPlatforms: Self.sampleEntitlements.supportedPlatforms
        )

        let generator = CodeGenerator(
            entitlements: customEntitlements,
            typeMappings: Self.sampleTypeMappings,
            excludedProperties: []
        )
        let output = generator.generatePropertyFile(
            for: "iOS",
            properties: customEntitlements.properties.ios
        )

        let expected = """
        public import AppEntitlements
        internal import Foundation

        // MARK: - Testing

        public extension AppEntitlements {
            /// Test enum property
            ///
            /// - SeeAlso: [Test enum property](https://developer.apple.com/test-enum)
            static var testEnumProperty: TestEnum? {
                get throws {
                    try AppEntitlements.getValue(for: Entitlement.testEnumProperty, as: TestEnum.self)
                }
            }
        }

        """

        #expect(output == expected)
    }

    @Test("Filter unsupported platforms from availability attributes")
    func filterUnsupportedPlatforms() {
        // Test with a hypothetical future platform that's not in supportedPlatforms
        let entitlementsWithUnsupportedPlatforms = EntitlementsData(
            version: "1.0",
            properties: .init(
                ios: [
                    EntitlementProperty(
                        name: "futurePlatformProperty",
                        entitlementKey: "futurePlatformProperty",
                        rawKey: "com.apple.future",
                        type: "String",
                        possibleValues: nil,
                        category: "Testing",
                        documentation: "Property with hypothetical future platform",
                        appleDocUrl: "https://developer.apple.com/future",
                        availability: [
                            Availability(platform: "iOS", introducedAt: "16.0", unavailable: false),
                            Availability(platform: "xrOS", introducedAt: "1.0", unavailable: false),
                            Availability(platform: "macOS", introducedAt: "13.0", unavailable: false),
                        ]
                    ),
                ],
                macOS: [],
                shared: []
            ),
            supportedPlatforms: Self.sampleEntitlements.supportedPlatforms
        )

        let generator = CodeGenerator(
            entitlements: entitlementsWithUnsupportedPlatforms,
            typeMappings: Self.sampleTypeMappings,
            excludedProperties: []
        )
        let output = generator.generatePropertyFile(
            for: "iOS",
            properties: entitlementsWithUnsupportedPlatforms.properties.ios
        )

        // xrOS should be filtered out, only iOS 16.0 and macOS 13.0 remain
        let expected = """
        public import AppEntitlements
        internal import Foundation

        // MARK: - Testing

        @available(iOS 16.0, macOS 13.0, *)
        public extension AppEntitlements {
            /// Property with hypothetical future platform
            ///
            /// - SeeAlso: [Property with hypothetical future platform](https://developer.apple.com/future)
            static var futurePlatformProperty: String? {
                get throws {
                    try AppEntitlements.getValue(for: Entitlement.futurePlatformProperty, as: String.self)
                }
            }
        }

        """

        #expect(output == expected)
    }

    @Test("Filter redundant availability attributes matching package minimum versions")
    func filterRedundantAvailability() {
        let entitlementsWithRedundantAvailability = EntitlementsData(
            version: "1.0",
            properties: .init(
                ios: [
                    EntitlementProperty(
                        name: "oldProperty",
                        entitlementKey: "oldProperty",
                        rawKey: "com.apple.old",
                        type: "String",
                        possibleValues: nil,
                        category: "Testing",
                        documentation: "Old property at iOS 15.0 (should be filtered)",
                        appleDocUrl: "https://developer.apple.com/old",
                        availability: [
                            Availability(platform: "iOS", introducedAt: "15.0", unavailable: false),
                        ]
                    ),
                    EntitlementProperty(
                        name: "newProperty",
                        entitlementKey: "newProperty",
                        rawKey: "com.apple.new",
                        type: "String",
                        possibleValues: nil,
                        category: "Testing",
                        documentation: "New property at iOS 16.0 (should be kept)",
                        appleDocUrl: "https://developer.apple.com/new",
                        availability: [
                            Availability(platform: "iOS", introducedAt: "16.0", unavailable: false),
                        ]
                    ),
                ],
                macOS: [],
                shared: []
            ),
            supportedPlatforms: Self.sampleEntitlements.supportedPlatforms
        )

        let generator = CodeGenerator(
            entitlements: entitlementsWithRedundantAvailability,
            typeMappings: Self.sampleTypeMappings,
            excludedProperties: []
        )
        let output = generator.generatePropertyFile(
            for: "iOS",
            properties: entitlementsWithRedundantAvailability.properties.ios
        )

        let expected = """
        public import AppEntitlements
        internal import Foundation

        // MARK: - Testing

        public extension AppEntitlements {
            /// Old property at iOS 15.0 (should be filtered)
            ///
            /// - SeeAlso: [Old property at iOS 15.0 (should be filtered)](https://developer.apple.com/old)
            static var oldProperty: String? {
                get throws {
                    try AppEntitlements.getValue(for: Entitlement.oldProperty, as: String.self)
                }
            }
        }

        @available(iOS 16.0, *)
        public extension AppEntitlements {
            /// New property at iOS 16.0 (should be kept)
            ///
            /// - SeeAlso: [New property at iOS 16.0 (should be kept)](https://developer.apple.com/new)
            static var newProperty: String? {
                get throws {
                    try AppEntitlements.getValue(for: Entitlement.newProperty, as: String.self)
                }
            }
        }

        """

        #expect(output == expected)
    }

    @Test("Exclude properties from generation")
    func excludedProperties() {
        let generator = CodeGenerator(
            entitlements: Self.sampleEntitlements,
            typeMappings: Self.sampleTypeMappings,
            excludedProperties: ["testEntitlement", "uncategorizedEntitlement"]
        )

        // Test enum generation excludes specified properties
        let enumOutput = generator.generateEntitlementEnumFile()
        let expectedEnum = """
        /// All known app entitlement keys.
        ///
        /// This enum provides type-safe access to entitlement identifiers used across Apple platforms.
        public enum Entitlement: String, Sendable {
            // MARK: - Testing

            /// An array entitlement
            ///
            /// - SeeAlso: [An array entitlement](https://developer.apple.com/array-test)
            @available(iOS 16.0, *)
            case arrayEntitlement = "com.apple.array-test"
        }

        """
        #expect(enumOutput == expectedEnum)

        // Test property file generation excludes specified properties
        let propertyOutput = generator.generatePropertyFile(
            for: "iOS",
            properties: Self.sampleEntitlements.properties.ios
        )
        let expectedProperty = """
        public import AppEntitlements
        internal import Foundation

        // MARK: - Testing

        @available(iOS 16.0, *)
        public extension AppEntitlements {
            /// An array entitlement
            ///
            /// - SeeAlso: [An array entitlement](https://developer.apple.com/array-test)
            static var arrayEntitlement: [String]? {
                get throws {
                    try AppEntitlements.getArray(for: Entitlement.arrayEntitlement, elementType: String.self)
                }
            }
        }

        """
        #expect(propertyOutput == expectedProperty)
    }

    // MARK: - Version Comparison Tests

    @Test("Version comparison", arguments: [
        ("15.0", "15.0", false),    // Same version
        ("16.0", "15.0", true),     // Higher major
        ("14.5", "15.0", false),    // Lower major
        ("15.1", "15.0", true),     // Higher minor
        ("15.0.1", "15.0", true),   // More components, equal prefix
        ("15.0", "15.0.1", false),  // Fewer components, equal prefix
    ] as [(String, String, Bool)])
    func versionComparison(version: String, baseline: String, expected: Bool) {
        let generator = CodeGenerator(
            entitlements: Self.sampleEntitlements,
            typeMappings: Self.sampleTypeMappings,
            excludedProperties: []
        )
        #expect(generator.isVersion(version, greaterThan: baseline) == expected)
    }
}

private extension CodeGeneratorTests {
    // MARK: - Test Data

    static let sampleEntitlements = EntitlementsData(
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
                        Availability(platform: "iOS", introducedAt: "15.0", unavailable: false),
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
                        Availability(platform: "iOS", introducedAt: "16.0", unavailable: false),
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
                        Availability(platform: "iOS", introducedAt: "15.0", unavailable: false),
                    ]
                ),
            ],
            macOS: [],
            shared: []
        ),
        supportedPlatforms: [
            SupportedPlatform(name: "iOS", version: "15.0"),
            SupportedPlatform(name: "macOS", version: "12.0"),
            SupportedPlatform(name: "tvOS", version: "15.0"),
            SupportedPlatform(name: "visionOS", version: "1.0"),
            SupportedPlatform(name: "watchOS", version: "8.0"),
        ]
    )

    static let sampleTypeMappings = TypeMappingsData(
        version: "1.0",
        enums: [
            EnumDefinition(
                name: "TestEnum",
                propertyName: "testEnumProperty",
                rawValueType: "String",
                documentation: "A test enum",
                cases: [
                    EnumCase(name: "case1", rawValue: "value1", documentation: "First case"),
                    EnumCase(name: "case2", rawValue: "value2", documentation: nil),
                ]
            ),
        ]
    )
}
