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
            var errors: [any Error] = []

            // Try to decode from linkEdit section (property list)
            if let linkEditData {
                do {
                    let linkEditEntitlements = try Self.decodePropertyListEntitlements(from: linkEditData)
                    entitlements.merge(linkEditEntitlements) { current, _ in current }
                } catch {
                    errors.append(error)
                }
            }

            // Try to decode from text section (property list)
            if let textSectionData {
                do {
                    let textSectionEntitlements = try Self.decodePropertyListEntitlements(from: textSectionData)
                    entitlements.merge(textSectionEntitlements) { current, _ in current }
                } catch {
                    errors.append(error)
                }
            }

            // Try to decode from linkEdit section (DER encoded)
            if let linkEditDataDER {
                do {
                    let linkEditEntitlementsDER = try Self.decodeEntitlementsDER(from: linkEditDataDER)
                    entitlements.merge(linkEditEntitlementsDER) { _, new in new }
                } catch {
                    errors.append(error)
                }
            }

            // If we got entitlements from at least one source, return them
            if !entitlements.isEmpty {
                return entitlements
            }

            // If we had errors but no successful decoding, throw the first error
            if let firstError = errors.first {
                throw firstError
            }

            // No data sources available and no errors - binary has no entitlements
            return [:]
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
            throw AppEntitlements.EntitlementsError.unexpectedFormat(
                "Expected entitlements property list to contain a dictionary at root"
            )
        }
        return dictionary
    }
}

extension AppEntitlements.EntitlementsData {
    static func decodeEntitlementsDER(from derData: Data) throws -> [String: PropertyListValue] {
        try AppEntitlements.DEREncoded(derEncoded: Array(derData)).values
    }
}
