public import Foundation

/// Type-safe representation of property list values.
///
/// Represents all possible value types that can appear in property lists and entitlement dictionaries.
public enum PropertyListValue: Hashable, Sendable {
    /// An array of property list values.
    case array([PropertyListValue])
    /// A dictionary mapping strings to property list values.
    case dictionary([String: PropertyListValue])
    /// Binary data.
    case data(Data)
    /// A string value.
    case string(String)
    /// A date value.
    case date(Date)
    /// A 32-bit integer value.
    case int32(Int32)
    /// A 64-bit integer value.
    case int64(Int64)
    /// A 32-bit floating point value.
    case float(Float32)
    /// A 64-bit floating point value.
    case double(Double)
    /// A boolean value.
    case bool(Bool)
}

extension PropertyListValue {
    static func mapPropertyListDictionary(_ dictionary: NSDictionary) -> [String: Self] {
        var mapped = [String: Self]()
        mapped.reserveCapacity(dictionary.count)

        for (key, value) in dictionary {
            guard let key = key as? String,
                  let value = Self(value)
            else {
                continue
            }
            mapped[key] = value
        }
        return mapped
    }

    init?(_ propertyListNumber: NSNumber) {
        switch CFNumberGetType(propertyListNumber) {
        case .sInt32Type:
            self = .int32(propertyListNumber.int32Value)
        case .sInt64Type:
            self = .int64(propertyListNumber.int64Value)
        case .float32Type:
            self = .float(propertyListNumber.floatValue)
        case .float64Type:
            self = .double(propertyListNumber.doubleValue)
        case .charType:
            self = .bool(propertyListNumber.boolValue)
        default:
            return nil
        }
    }

    init?(_ propertyListObject: Any) {
        switch propertyListObject {
        case let value as Data:
            self = .data(value)

        case let value as String:
            self = .string(value)

        case let value as Date:
            self = .date(value)

        case let number as NSNumber:
            guard let value = Self(number) else { return nil }
            self = value

        case let values as NSArray:
            self = .array(
                values.compactMap { Self($0) }
            )

        case let values as NSDictionary:
            self = .dictionary(
                Self.mapPropertyListDictionary(values)
            )

        default:
            return nil
        }
    }
}
