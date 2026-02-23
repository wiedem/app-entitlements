internal import ArgumentParser
private import Foundation

@main
struct EntitlementsCodeGenTool: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "entitlements-codegen-tool",
        abstract: "Generate Swift code for entitlement definitions from JSON metadata."
    )

    @Option(name: .long, help: "Path to the entitlements JSON file.")
    var entitlementsJson: String

    @Option(name: .long, help: "Path to the type mappings JSON file.")
    var typeMappingsJson: String

    @Option(name: .long, help: "Output directory for generated Swift files.")
    var outputDir: String

    func run() throws {
        // Load JSON files
        let entitlementsData = try Data(contentsOf: URL(fileURLWithPath: entitlementsJson))
        let typeMappingsData = try Data(contentsOf: URL(fileURLWithPath: typeMappingsJson))

        let decoder = JSONDecoder()
        let entitlements = try decoder.decode(EntitlementsData.self, from: entitlementsData)
        let typeMappings = try decoder.decode(TypeMappingsData.self, from: typeMappingsData)

        // Validate all entitlement types
        try EntitlementValidator.validate(entitlements)

        let outputURL = URL(fileURLWithPath: outputDir)
        try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: true)

        print("✅ JSON files loaded successfully")
        print("   - Entitlements: \(entitlements.properties.ios.count + entitlements.properties.macOS.count + entitlements.properties.shared.count) properties")
        print("   - Type Mappings: \(typeMappings.enums.count) enums")
        print("   - Output directory: \(outputDir)")

        // Initialize code generator
        let generator = CodeGenerator(entitlements: entitlements, typeMappings: typeMappings)

        // Generate Entitlement.swift
        let entitlementEnumCode = generator.generateEntitlementEnumFile()
        let entitlementFile = outputURL.appendingPathComponent("Entitlement.swift")
        try entitlementEnumCode.write(to: entitlementFile, atomically: true, encoding: .utf8)
        print("✅ Generated: Entitlement.swift")

        // Generate EntitlementValueTypes.swift
        let valueTypesCode = generator.generateValueTypesFile()
        let valueTypesFile = outputURL.appendingPathComponent("EntitlementValueTypes.swift")
        try valueTypesCode.write(to: valueTypesFile, atomically: true, encoding: .utf8)
        print("✅ Generated: EntitlementValueTypes.swift")

        // Generate AppEntitlements+iOS.swift
        let iOSCode = generator.generatePropertyFile(for: "iOS", properties: entitlements.properties.ios)
        let iOSFile = outputURL.appendingPathComponent("AppEntitlements+iOS.swift")
        try iOSCode.write(to: iOSFile, atomically: true, encoding: .utf8)
        print("✅ Generated: AppEntitlements+iOS.swift")

        // Generate AppEntitlements+macOS.swift
        let macOSCode = generator.generatePropertyFile(for: "macOS", properties: entitlements.properties.macOS)
        let macOSFile = outputURL.appendingPathComponent("AppEntitlements+macOS.swift")
        try macOSCode.write(to: macOSFile, atomically: true, encoding: .utf8)
        print("✅ Generated: AppEntitlements+macOS.swift")

        // Generate AppEntitlements+Shared.swift
        let sharedCode = generator.generatePropertyFile(for: "Shared", properties: entitlements.properties.shared)
        let sharedFile = outputURL.appendingPathComponent("AppEntitlements+Shared.swift")
        try sharedCode.write(to: sharedFile, atomically: true, encoding: .utf8)
        print("✅ Generated: AppEntitlements+Shared.swift")

        print("✨ Code generation completed successfully!")
    }
}
