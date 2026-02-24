internal import Foundation
internal import SwiftASN1

extension AppEntitlements {
    struct DEREncoded: DERParseable {
        private static let identifier = ASN1Identifier(tagWithNumber: 16, tagClass: .application)

        let values: [String: PropertyListValue]

        init(derEncoded node: ASN1Node) throws {
            values = try DER.sequence(node, identifier: Self.identifier) { nodes in
                let version = try UInt8(derEncoded: &nodes)
                guard version == 1 else {
                    throw AppEntitlements.DEREncodingError.unsupportedVersion
                }
                return try PropertyList(derEncoded: &nodes).values
            }
        }
    }
}

private extension AppEntitlements.DEREncoded {
    struct PropertyList: DERParseable {
        private static let identifier = ASN1Identifier(tagWithNumber: 16, tagClass: .contextSpecific)

        let values: [String: PropertyListValue]

        init(derEncoded node: ASN1Node) throws {
            try values = DER.sequence(node, identifier: Self.identifier) { nodes in
                var values = [String: PropertyListValue]()

                while let node = nodes.next() {
                    // Intentionally using try? for resilience: Individual malformed key-value pairs
                    // should not cause the entire entitlements dictionary to fail parsing.
                    if let tuple = try? KeyValueTuple(derEncoded: node) {
                        values[tuple.key] = tuple.value
                    }
                }
                return values
            }
        }
    }

    struct KeyValueTuple: DERParseable {
        private static let identifier = ASN1Identifier.sequence

        let key: String
        let value: PropertyListValue

        init(derEncoded node: ASN1Node) throws {
            try (key, value) = DER.sequence(node, identifier: Self.identifier) { nodes in
                let key = try String(decoding: ASN1UTF8String(derEncoded: &nodes))
                guard let node = nodes.next() else {
                    throw AppEntitlements.DEREncodingError.invalidEntitlementData
                }
                let value = try PropertyListValue(derEncoded: node)
                return (key, value)
            }
        }
    }
}
