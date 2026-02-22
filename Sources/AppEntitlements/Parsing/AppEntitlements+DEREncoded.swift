internal import Foundation
internal import SwiftASN1

extension AppEntitlements {
    struct DEREncoded: DERImplicitlyTaggable {
        static let defaultIdentifier = ASN1Identifier(tagWithNumber: 16, tagClass: .application)

        let values: [String: PropertyListValue]

        init(values: [String: PropertyListValue]) {
            self.values = values
        }

        init(
            derEncoded node: ASN1Node,
            withIdentifier identifier: ASN1Identifier
        ) throws {
            values = try DER.sequence(node, identifier: identifier) { nodes in
                let version = try UInt8(derEncoded: &nodes)
                guard version == 1 else {
                    throw DEREncodingError.unsupportedVersion
                }
                return try PropertyList(derEncoded: &nodes).values
            }
        }

        func serialize(
            into coder: inout DER.Serializer,
            withIdentifier identifier: ASN1Identifier
        ) throws {
            try coder.appendConstructedNode(identifier: identifier) { coder in
                try coder.serialize(UInt8(1))
                try coder.serialize(PropertyList(values: values))
            }
        }
    }
}

private extension AppEntitlements.DEREncoded {
    struct PropertyList: DERImplicitlyTaggable {
        static let defaultIdentifier = ASN1Identifier(tagWithNumber: 16, tagClass: .contextSpecific)

        let values: [String: PropertyListValue]

        init(values: [String: PropertyListValue]) {
            self.values = values
        }

        init(
            derEncoded node: ASN1Node,
            withIdentifier identifier: ASN1Identifier
        ) throws {
            try values = DER.sequence(node, identifier: identifier) { nodes in
                var values = [String: PropertyListValue]()

                while let node = nodes.next() {
                    if let tuple = try? KeyValueTuple(derEncoded: node) {
                        values[tuple.key] = tuple.value
                    }
                }
                return values
            }
        }

        func serialize(
            into coder: inout DER.Serializer,
            withIdentifier identifier: ASN1Identifier
        ) throws {
            try coder.appendConstructedNode(identifier: identifier) { coder in
                for (key, value) in values {
                    try coder.appendConstructedNode(identifier: .sequence) { coder in
                        try coder.serialize(ASN1UTF8String(key))
                        try value.serialize(into: &coder)
                    }
                }
            }
        }
    }

    struct KeyValueTuple: DERImplicitlyTaggable {
        static let defaultIdentifier = ASN1Identifier.sequence

        let key: String
        let value: PropertyListValue

        init(
            key: String,
            value: PropertyListValue
        ) {
            self.key = key
            self.value = value
        }

        init(
            derEncoded node: ASN1Node,
            withIdentifier identifier: ASN1Identifier
        ) throws {
            try (key, value) = DER.sequence(node, identifier: identifier) { nodes in
                let key = try String(decoding: ASN1UTF8String(derEncoded: &nodes))
                guard let node = nodes.next() else {
                    throw AppEntitlements.DEREncodingError.invalidEntitlementData
                }
                let value = try PropertyListValue(derEncoded: node)
                return (key, value)
            }
        }

        func serialize(
            into _: inout DER.Serializer,
            withIdentifier _: ASN1Identifier
        ) throws {
            fatalError("Encoding KeyValueTuple is not supported")
        }
    }
}
