// MARK: - Entitlements JSON Models

struct EntitlementsData: Codable {
    let version: String
    let properties: Properties

    struct Properties: Codable {
        let ios: [EntitlementProperty]
        let macOS: [EntitlementProperty]
        let shared: [EntitlementProperty]
    }
}

struct EntitlementProperty: Codable, Equatable {
    let name: String
    let entitlementKey: String
    let rawKey: String
    let type: String
    let possibleValues: [String]?
    let category: String?
    let documentation: String
    let appleDocUrl: String
    let availability: [Availability]
}

struct Availability: Codable, Equatable {
    let platform: String
    let introducedAt: String
    let unavailable: Bool?
}

// MARK: - Type Mappings JSON Models

struct TypeMappingsData: Codable {
    let version: String
    let enums: [EnumDefinition]
}

struct EnumDefinition: Codable {
    let name: String
    let propertyName: String
    let rawValueType: String
    let documentation: String
    let cases: [EnumCase]
}

struct EnumCase: Codable {
    let name: String
    let rawValue: String
    let documentation: String?
}
