public import Foundation

public extension PropertyListValue {
    /// Returns the value converted to the requested type if it matches a supported property list type.
    ///
    /// - Parameter type: The expected value type. Defaults to inferred generic type `T`.
    /// - Returns: The typed value if the underlying case matches.
    /// - Throws: `PropertyListValueError.unsupportedType` if the type is not supported,
    ///           or `PropertyListValueError.typeMismatch` if the value cannot be converted to the requested type.
    func value<T>(_ type: T.Type = T.self) throws -> T? {
        func extract(_ value: (some Any)?) throws -> T {
            guard let value else {
                throw PropertyListValueError.typeMismatch(expected: type, actual: self)
            }
            return (value as! T)
        }

        switch type {
        case is [PropertyListValue].Type:
            return try extract(arrayValue)
        case is [String: PropertyListValue].Type:
            return try extract(dictionaryValue)
        case is Data.Type:
            return try extract(dataValue)
        case is String.Type:
            return try extract(stringValue)
        case is Date.Type:
            return try extract(dateValue)
        case is Int32.Type:
            return try extract(int32Value)
        case is Int64.Type:
            return try extract(int64Value)
        case is Float.Type:
            return try extract(floatValue)
        case is Double.Type:
            return try extract(doubleValue)
        case is Bool.Type:
            return try extract(boolValue)
        default:
            throw PropertyListValueError.unsupportedType(type)
        }
    }
}

public extension PropertyListValue {
    /// Returns the value as an array if it is an array type.
    var arrayValue: [PropertyListValue]? {
        guard case let .array(array) = self else {
            return nil
        }
        return array
    }

    /// Returns the value as a dictionary if it is a dictionary type.
    var dictionaryValue: [String: PropertyListValue]? {
        guard case let .dictionary(dictionary) = self else {
            return nil
        }
        return dictionary
    }

    /// Returns the value as data if it is a data type.
    var dataValue: Data? {
        guard case let .data(data) = self else {
            return nil
        }
        return data
    }

    /// Returns the value as a string if it is a string type.
    var stringValue: String? {
        guard case let .string(string) = self else {
            return nil
        }
        return string
    }

    /// Returns the value as a date if it is a date type.
    var dateValue: Date? {
        guard case let .date(date) = self else {
            return nil
        }
        return date
    }

    /// Returns the value as a 32-bit integer if it is an int32 type.
    var int32Value: Int32? {
        guard case let .int32(int32) = self else {
            return nil
        }
        return int32
    }

    /// Returns the value as a 64-bit integer if it is an int64 type.
    var int64Value: Int64? {
        guard case let .int64(int64) = self else {
            return nil
        }
        return int64
    }

    /// Returns the value as a float if it is a float type.
    var floatValue: Float? {
        guard case let .float(float) = self else {
            return nil
        }
        return float
    }

    /// Returns the value as a double if it is a double type.
    var doubleValue: Double? {
        guard case let .double(double) = self else {
            return nil
        }
        return double
    }

    /// Returns the value as a boolean if it is a bool type.
    var boolValue: Bool? {
        guard case let .bool(bool) = self else {
            return nil
        }
        return bool
    }
}
