// swift-tools-version: 6.0
import CompilerPluginSupport
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
    ],
    products: [
        .library(
            name: "AppEntitlements",
            targets: ["AppEntitlements"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-asn1.git", .upToNextMajor(from: "1.5.0")),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        // Core types (shared between macro and main library)
        .target(
            name: "AppEntitlementsCore",
            dependencies: [],
            swiftSettings: commonSwiftSettings
        ),
        // Macro implementation (compiler plugin)
        .macro(
            name: "AppEntitlementsMacrosPlugin",
            dependencies: [
                .product(
                    name: "SwiftSyntaxMacros",
                    package: "swift-syntax"
                ),
                .product(
                    name: "SwiftCompilerPlugin",
                    package: "swift-syntax"
                ),
                "AppEntitlementsCore",
            ],
            swiftSettings: commonSwiftSettings
        ),
        // Macro definitions (public API)
        .target(
            name: "AppEntitlementsMacros",
            dependencies: [
                .target(name: "AppEntitlementsMacrosPlugin"),
                "AppEntitlementsCore",
            ],
            swiftSettings: commonSwiftSettings
        ),
        // Main library target
        .target(
            name: "AppEntitlements",
            dependencies: [
                .product(name: "SwiftASN1", package: "swift-asn1"),
                "AppEntitlementsMacros",
                "AppEntitlementsCore",
            ],
            path: "Sources",
            exclude: [
                "AppEntitlementsMacros",
                "AppEntitlementsMacrosPlugin",
                "AppEntitlementsCore",
            ],
            resources: [
                .process("Resources/PrivacyInfo.xcprivacy"),
            ],
            swiftSettings: commonSwiftSettings
        ),
        // Tests
        .testTarget(
            name: "AppEntitlementsTests",
            dependencies: ["AppEntitlements"],
            swiftSettings: commonSwiftSettings
        ),
        .testTarget(
            name: "AppEntitlementsMacrosTests",
            dependencies: [
                "AppEntitlementsMacros",
                .target(
                    name: "AppEntitlementsMacrosPlugin",
                    condition: .when(platforms: [.macOS])
                ),
                .product(
                    name: "SwiftSyntaxMacrosTestSupport",
                    package: "swift-syntax",
                    condition: .when(platforms: [.macOS])
                ),
            ],
            swiftSettings: commonSwiftSettings
        ),
    ],
    swiftLanguageModes: [.v6]
)
