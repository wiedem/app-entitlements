internal import SwiftASN1

extension PropertyListValue {
    init(derEncoded node: ASN1Node) throws(PropertyListValueError) {
        switch node.identifier {
        case .boolean:
            try self = Self.mapDecodingError {
                try .bool(Bool(derEncoded: node))
            }

        case .utf8String:
            try self = Self.mapDecodingError {
                try .string(String(
                    decoding: ASN1UTF8String(derEncoded: node).bytes,
                    as: UTF8.self
                ))
            }

        case .integer:
            try self = Self.mapDecodingError {
                try .int64(Int64(derEncoded: node))
            }

        case .sequence:
            try self = Self.mapDecodingError {
                let values = try DER.sequence(node, identifier: .sequence) { nodes in
                    var values = [PropertyListValue]()

                    while let node = nodes.next() {
                        try values.append(
                            .string(String(decoding: ASN1UTF8String(derEncoded: node)))
                        )
                    }
                    return values
                }
                return .array(values)
            }

        default:
            throw PropertyListValueError.unsupportedDataType
        }
    }
}

extension PropertyListValue {
    func serialize(into coder: inout DER.Serializer) throws {
        switch self {
        case let .string(value):
            try coder.serialize(ASN1UTF8String(value))
        case let .bool(value):
            try coder.serialize(value)
        case let .int32(value):
            try coder.serialize(value)
        case let .int64(value):
            try coder.serialize(value)
        case let .array(values):
            try coder.appendConstructedNode(identifier: .sequence) { coder in
                for value in values {
                    try value.serialize(into: &coder)
                }
            }
        case .dictionary, .data, .date, .float, .double:
            throw AppEntitlements.DEREncodingError.unsupportedPropertyListValue
        }
    }
}

private extension PropertyListValue {
    static func mapDecodingError<T>(_ perform: () throws -> T) throws(PropertyListValueError) -> T {
        do {
            return try perform()
        } catch {
            throw PropertyListValueError.decodingError(error)
        }
    }
}
