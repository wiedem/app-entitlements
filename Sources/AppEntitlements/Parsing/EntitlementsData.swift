internal import Foundation

extension AppEntitlements {
    struct EntitlementsData: Sendable {
        static let none = EntitlementsData(
            linkEditData: nil,
            linkEditDataDER: nil,
            textSectionData: nil
        )

        let linkEditData: Data?
        let linkEditDataDER: Data?
        let textSectionData: Data?

        init(
            linkEditData: Data?,
            linkEditDataDER: Data?,
            textSectionData: Data?
        ) {
            self.linkEditData = linkEditData
            self.linkEditDataDER = linkEditDataDER
            self.textSectionData = textSectionData
        }

        func decode() throws -> [String: PropertyListValue] {
            var entitlements = [String: PropertyListValue]()

            if let linkEditData {
                let linkEditEntitlements = try Self.decodePropertyListEntitlements(from: linkEditData)
                entitlements.merge(linkEditEntitlements) { current, _ in current }
            }

            if let textSectionData {
                let textSectionEntitlements = try Self.decodePropertyListEntitlements(from: textSectionData)
                entitlements.merge(textSectionEntitlements) { current, _ in current }
            }

            if let linkEditDataDER {
                let linkEditEntitlementsDER = try Self.decodeEntitlementsDER(from: linkEditDataDER)
                entitlements.merge(linkEditEntitlementsDER) { _, new in new }
            }

            return entitlements
        }
    }
}

extension AppEntitlements.EntitlementsData {
    static func decodePropertyListEntitlements(from plistData: Data) throws -> [String: PropertyListValue] {
        let propertyList = try PropertyListSerialization.propertyList(
            from: plistData,
            format: nil
        )

        guard case let .dictionary(dictionary) = PropertyListValue(propertyList) else {
            return [:]
        }
        return dictionary
    }
}

extension AppEntitlements.EntitlementsData {
    static func decodeEntitlementsDER(from derData: Data) throws -> [String: PropertyListValue] {
        try AppEntitlements.DEREncoded(derEncoded: Array(derData)).values
    }
}
