import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct AppEntitlementsMacrosPlugin: CompilerPlugin {
    let providingMacros: [any Macro.Type] = [
        EntitlementMacro.self,
    ]
}
