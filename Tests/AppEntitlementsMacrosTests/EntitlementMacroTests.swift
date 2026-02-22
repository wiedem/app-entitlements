import AppEntitlementsMacros
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros
import SwiftSyntaxMacrosGenericTestSupport
import Testing

// Note that the macros plugin module can only be imported when the target is set to macOS.
#if canImport(AppEntitlementsMacrosPlugin)
import AppEntitlementsMacrosPlugin

private let macroPluginModuleAvailable = true

private extension EntitlementMacroTests {
    static var testMacros: [String: MacroSpec] {
        ["Entitlement": .init(type: EntitlementMacro.self)]
    }
}
#else

private let macroPluginModuleAvailable = false

private extension EntitlementMacroTests {
    static var testMacros: [String: MacroSpec] {
        [:]
    }
}
#endif

@Suite(
    "Entitlement Macro Tests",
    .enabled(if: macroPluginModuleAvailable, "Macro plugin module AppEntitlementsMacrosPlugin is not available")
)
struct EntitlementMacroTests {
    @Test("Generates throwing getter with type-inferred syntax")
    func generatesThrowingGetterTypeInferred() {
        assertMacroExpansion(
            """
            @Entitlement(.teamIdentifier)
            static var teamIdentifier: String?
            """,
            expandedSource: """
            static var teamIdentifier: String? {
                get throws {
                    try AppEntitlements.getValue(for: Entitlement.teamIdentifier, as: String.self)
                }
            }
            """,
            macroSpecs: Self.testMacros
        )
    }

    @Test("Generates throwing getter for array entitlement")
    func generatesThrowingGetterForArray() {
        assertMacroExpansion(
            """
            @Entitlement(.keychainAccessGroups)
            static var keychainAccessGroups: [String]?
            """,
            expandedSource: """
            static var keychainAccessGroups: [String]? {
                get throws {
                    try AppEntitlements.getArray(for: Entitlement.keychainAccessGroups, elementType: String.self)
                }
            }
            """,
            macroSpecs: Self.testMacros
        )
    }

    @Test("Generates throwing getter for custom identifier")
    func generatesThrowingGetterForCustomIdentifier() {
        assertMacroExpansion(
            """
            @Entitlement(CustomEntitlement.testEntitlement)
            static var customValue: String?
            """,
            expandedSource: """
            static var customValue: String? {
                get throws {
                    try AppEntitlements.getValue(for: CustomEntitlement.testEntitlement, as: String.self)
                }
            }
            """,
            macroSpecs: Self.testMacros
        )
    }

    @Test("Reports error for missing type annotation")
    func reportsErrorForMissingTypeAnnotation() throws {
        _ = try #require(macroExpansionFailure(
            """
            @Entitlement(.teamIdentifier)
            static var teamIdentifier
            """,
            expandedSource: """
            @Entitlement(.teamIdentifier)
            static var teamIdentifier
            """,
            macroSpecs: Self.testMacros
        ))
    }

    @Test("Reports error for missing identifier argument")
    func reportsErrorForMissingIdentifierArgument() throws {
        _ = try #require(macroExpansionFailure(
            """
            @Entitlement
            static var teamIdentifier: String?
            """,
            expandedSource: """
            @Entitlement
            static var teamIdentifier: String?
            """,
            macroSpecs: Self.testMacros
        ))
    }
}
