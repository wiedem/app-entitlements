@testable import AppEntitlements
import Foundation
import Testing

struct ValueConversionTests {
    // MARK: - convertValue Tests

    @Test("Convert PropertyListValue to String")
    func convertToString() throws {
        let value = PropertyListValue.string("test")
        let result = try AppEntitlements.convertValue(value, to: String.self)
        #expect(result == "test")
    }

    @Test("Convert PropertyListValue to Bool")
    func convertToBool() throws {
        let value = PropertyListValue.bool(true)
        let result = try AppEntitlements.convertValue(value, to: Bool.self)
        #expect(result == true)
    }

    @Test("Convert PropertyListValue to Int32")
    func convertToInt32() throws {
        let value = PropertyListValue.int32(42)
        let result = try AppEntitlements.convertValue(value, to: Int32.self)
        #expect(result == 42)
    }

    @Test("Convert PropertyListValue to Int64")
    func convertToInt64() throws {
        let value = PropertyListValue.int64(9_876_543_210)
        let result = try AppEntitlements.convertValue(value, to: Int64.self)
        #expect(result == 9_876_543_210)
    }

    @Test("Convert PropertyListValue to Float")
    func convertToFloat() throws {
        let value = PropertyListValue.float(3.14)
        let result = try AppEntitlements.convertValue(value, to: Float.self)
        #expect(result == 3.14)
    }

    @Test("Convert PropertyListValue to Double")
    func convertToDouble() throws {
        let value = PropertyListValue.double(3.14159)
        let result = try AppEntitlements.convertValue(value, to: Double.self)
        #expect(result == 3.14159)
    }

    @Test("Convert PropertyListValue to Data")
    func convertToData() throws {
        let data = Data([1, 2, 3, 4])
        let value = PropertyListValue.data(data)
        let result = try AppEntitlements.convertValue(value, to: Data.self)
        #expect(result == data)
    }

    @Test("Convert PropertyListValue to Date")
    func convertToDate() throws {
        let date = Date()
        let value = PropertyListValue.date(date)
        let result = try AppEntitlements.convertValue(value, to: Date.self)
        #expect(result == date)
    }

    @Test("Convert PropertyListValue array to [String]")
    func convertToStringArray() throws {
        let value = PropertyListValue.array([
            .string("first"),
            .string("second"),
            .string("third"),
        ])
        let result = try AppEntitlements.convertArray(value, elementType: String.self)
        #expect(result == ["first", "second", "third"])
    }

    @Test("Convert PropertyListValue to [PropertyListValue]")
    func convertToPropertyListValueArray() throws {
        let array: [PropertyListValue] = [.string("test"), .int32(42)]
        let value = PropertyListValue.array(array)
        let result = try AppEntitlements.convertValue(value, to: [PropertyListValue].self)
        #expect(result == array)
    }

    @Test("Convert PropertyListValue to [String: PropertyListValue]")
    func convertToPropertyListValueDictionary() throws {
        let dict: [String: PropertyListValue] = [
            "key1": .string("value1"),
            "key2": .int32(42),
        ]
        let value = PropertyListValue.dictionary(dict)
        let result = try AppEntitlements.convertValue(value, to: [String: PropertyListValue].self)
        #expect(result == dict)
    }

    @Test("Convert type mismatch throws error")
    func convertTypeMismatchThrows() throws {
        let value = PropertyListValue.string("not a number")
        #expect(throws: PropertyListValueError.self) {
            try AppEntitlements.convertValue(value, to: Int32.self)
        }
    }

    // MARK: - convertArray Tests

    @Test("Convert array with valid string elements")
    func convertArrayWithValidStrings() throws {
        let value = PropertyListValue.array([
            .string("first"),
            .string("second"),
            .string("third"),
        ])
        let result = try AppEntitlements.convertArray(value, elementType: String.self)
        #expect(result == ["first", "second", "third"])
    }

    @Test("Convert empty array returns empty result")
    func convertEmptyArray() throws {
        let value = PropertyListValue.array([])
        let result = try AppEntitlements.convertArray(value, elementType: String.self)
        #expect(result?.isEmpty == true)
    }

    @Test("Convert array with mixed types throws error")
    func convertArrayWithMixedTypesThrows() throws {
        let value = PropertyListValue.array([
            .string("first"),
            .int32(42), // Not a string
            .string("third"),
        ])
        #expect(throws: PropertyListValueError.self) {
            try AppEntitlements.convertArray(value, elementType: String.self)
        }
    }

    @Test("Convert array with Int32 elements")
    func convertArrayWithInt32Elements() throws {
        let value = PropertyListValue.array([
            .int32(1),
            .int32(2),
            .int32(3),
        ])
        let result = try AppEntitlements.convertArray(value, elementType: Int32.self)
        #expect(result == [1, 2, 3])
    }

    @Test("Convert [String] with mixed types in array throws error")
    func convertStringArrayWithMixedTypesThrows() throws {
        let value = PropertyListValue.array([
            .string("first"),
            .int32(42), // Not a string
            .string("third"),
        ])

        #expect(throws: PropertyListValueError.self) {
            try AppEntitlements.convertValue(value, to: [String].self)
        }
    }

    // MARK: - convertRawValue Tests

    @Test("Convert valid raw value to enum case")
    func convertRawValueSuccess() throws {
        let value = PropertyListValue.string("production")
        let result = try AppEntitlements.convertRawValue(value, to: MockEnvironment.self)
        #expect(result == .production)
    }

    @Test("Convert invalid raw value throws", arguments: [
        PropertyListValue.string("staging"),  // Valid type, unknown enum case
        PropertyListValue.int32(42),          // Wrong PropertyListValue type
    ])
    func convertRawValueThrows(value: PropertyListValue) {
        #expect(throws: PropertyListValueError.self) {
            try AppEntitlements.convertRawValue(value, to: MockEnvironment.self)
        }
    }
}

private enum MockEnvironment: String {
    case development
    case production
}
