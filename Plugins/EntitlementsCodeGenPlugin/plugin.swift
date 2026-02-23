private import Foundation
internal import PackagePlugin

/// Build tool plugin that generates entitlement definitions from JSON metadata.
///
/// This plugin runs during the build process and generates Swift code for type-safe
/// entitlement access without requiring Swift macros.
@main
struct EntitlementsCodeGenPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        // Only run for the AppEntitlements target
        guard target.name == "AppEntitlements" else {
            return []
        }

        // Locate JSON resource files
        let resourcesPath = context.package.directoryURL
            .appending(path: "Sources/AppEntitlements/Resources")

        let entitlementsJSON = resourcesPath.appending(path: "entitlements.json")
        let typeMappingsJSON = resourcesPath.appending(path: "entitlement-type-mappings.json")

        // Output directory for generated code
        let outputDir = context.pluginWorkDirectoryURL.appending(path: "GeneratedSources")

        // Define output files
        let outputFiles = [
            outputDir.appending(path: "Entitlement.swift"),
            outputDir.appending(path: "EntitlementValueTypes.swift"),
            outputDir.appending(path: "AppEntitlements+iOS.swift"),
            outputDir.appending(path: "AppEntitlements+macOS.swift"),
            outputDir.appending(path: "AppEntitlements+Shared.swift"),
        ]

        // Get code generation tool
        let tool = try context.tool(named: "entitlements-codegen-tool")

        // Create build command
        return [
            .buildCommand(
                displayName: "Generate Entitlements Code",
                executable: tool.url,
                arguments: [
                    "--entitlements-json", entitlementsJSON.path(),
                    "--type-mappings-json", typeMappingsJSON.path(),
                    "--output-dir", outputDir.path(),
                ],
                inputFiles: [
                    entitlementsJSON,
                    typeMappingsJSON,
                ],
                outputFiles: outputFiles
            ),
        ]
    }
}
