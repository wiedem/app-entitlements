private import Foundation
internal import PackagePlugin

/// Build tool plugin that generates entitlement definitions from JSON metadata.
///
/// This plugin runs during the build process and generates Swift code for type-safe
/// entitlement access without requiring Swift macros.
@main
struct EntitlementsCodeGenPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        // Only run for the AppEntitlementsCatalog target
        guard target.name == "AppEntitlementsCatalog" else {
            return []
        }

        // Locate JSON metadata files in EntitlementsMetadata/ at package root
        let metadataPath = context.package.directoryURL
            .appending(path: "EntitlementsMetadata")

        let entitlementsJSON = metadataPath.appending(path: "entitlements.json")
        let typeMappingsJSON = metadataPath.appending(path: "entitlement-type-mappings.json")
        let excludedEntitlementsJSON = metadataPath.appending(path: "excluded-entitlements.json")

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
                    "--excluded-entitlements-json", excludedEntitlementsJSON.path(),
                    "--output-dir", outputDir.path(),
                ],
                inputFiles: [
                    entitlementsJSON,
                    typeMappingsJSON,
                    excludedEntitlementsJSON,
                ],
                outputFiles: outputFiles
            ),
        ]
    }
}
