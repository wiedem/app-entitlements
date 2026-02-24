// swift-tools-version: 6.0
import PackageDescription

let commonSwiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableUpcomingFeature("StrictConcurrency"),
]

let package = Package(
    name: "AppEntitlements",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "AppEntitlements",
            targets: ["AppEntitlements"]
        ),
        .library(
            name: "AppEntitlementsCatalog",
            targets: ["AppEntitlementsCatalog"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-asn1.git", .upToNextMajor(from: "1.5.0")),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.5.0"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        // Core library target (no plugin, no trust prompt)
        .target(
            name: "AppEntitlements",
            dependencies: [
                .product(name: "SwiftASN1", package: "swift-asn1"),
            ],
            path: "Sources/AppEntitlements",
            resources: [
                .process("Resources/PrivacyInfo.xcprivacy"),
            ],
            swiftSettings: commonSwiftSettings
        ),
        // Catalog target with generated entitlements (requires trust prompt)
        .target(
            name: "AppEntitlementsCatalog",
            dependencies: ["AppEntitlements"],
            path: "Sources/AppEntitlementsCatalog",
            swiftSettings: commonSwiftSettings,
            plugins: [
                .plugin(name: "EntitlementsCodeGenPlugin"),
            ]
        ),
        // Tests
        .testTarget(
            name: "AppEntitlementsTests",
            dependencies: ["AppEntitlements"],
            swiftSettings: commonSwiftSettings
        ),
        .testTarget(
            name: "CodeGeneratorTests",
            dependencies: ["entitlements-codegen-tool"],
            path: "Tests/CodeGeneratorTests",
            swiftSettings: commonSwiftSettings
        ),
        // Build Plugin
        .plugin(
            name: "EntitlementsCodeGenPlugin",
            capability: .buildTool(),
            dependencies: ["entitlements-codegen-tool"]
        ),
        // Build Tool (Executable)
        .executableTarget(
            name: "entitlements-codegen-tool",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Plugins/EntitlementsCodeGenTool",
            swiftSettings: commonSwiftSettings
        ),
    ],
    swiftLanguageModes: [.v6]
)
