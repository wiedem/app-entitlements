@testable import AppEntitlements
internal import Foundation
internal import Testing
internal import SwiftASN1

struct EntitlementsErrorTests {
    @Test("Test PropertyListValueError for invalid DER data")
    func testInvalidDERThrowsDecodingError() {
        // Invalid DER data (truncated)
        let invalidDER = Data([0x70, 0x10, 0x02, 0x01])

        // ASN1 parsing will throw first, which is expected
        #expect(throws: (any Error).self) {
            _ = try AppEntitlements.DEREncoded(derEncoded: Array(invalidDER))
        }
    }

    @Test("Test PropertyListValueError for corrupted PropertyList")
    func testCorruptedPropertyListThrowsError() {
        let corruptedPlist = Data([0xFF, 0xFF, 0xFF, 0xFF])

        #expect(throws: (any Error).self) {
            _ = try AppEntitlements.EntitlementsData.decodePropertyListEntitlements(
                from: corruptedPlist
            )
        }
    }

    @Test("Test DEREncodingError for unsupported value types")
    func testUnsupportedPropertyListValueThrowsError() throws {
        // Dictionary type is not supported in DER encoding
        let dictValue = PropertyListValue.dictionary(["key": .string("value")])

        #expect(throws: AppEntitlements.DEREncodingError.self) {
            var serializer = DER.Serializer()
            try dictValue.serialize(into: &serializer)
        }
    }

    @Test("Test unsupported Data type throws error")
    func testUnsupportedDataTypeThrowsError() throws {
        let dataValue = PropertyListValue.data(Data([1, 2, 3]))

        #expect(throws: AppEntitlements.DEREncodingError.self) {
            var serializer = DER.Serializer()
            try dataValue.serialize(into: &serializer)
        }
    }

    @Test("Test unsupported Date type throws error")
    func testUnsupportedDateTypeThrowsError() throws {
        let dateValue = PropertyListValue.date(Date())

        #expect(throws: AppEntitlements.DEREncodingError.self) {
            var serializer = DER.Serializer()
            try dateValue.serialize(into: &serializer)
        }
    }

    @Test("Test unsupported Float type throws error")
    func testUnsupportedFloatTypeThrowsError() throws {
        let floatValue = PropertyListValue.float(1.5)

        #expect(throws: AppEntitlements.DEREncodingError.self) {
            var serializer = DER.Serializer()
            try floatValue.serialize(into: &serializer)
        }
    }

    @Test("Test unsupported Double type throws error")
    func testUnsupportedDoubleTypeThrowsError() throws {
        let doubleValue = PropertyListValue.double(2.5)

        #expect(throws: AppEntitlements.DEREncodingError.self) {
            var serializer = DER.Serializer()
            try doubleValue.serialize(into: &serializer)
        }
    }

    @Test("Test PropertyListValue with unsupported ASN1 type")
    func testUnsupportedASN1TypeThrowsError() throws {
        // Create DER data with NULL type (unsupported)
        let nullDER: [UInt8] = [0x05, 0x00] // NULL tag + 0 length
        let node = try DER.parse(nullDER)

        #expect(throws: PropertyListValueError.self) {
            _ = try PropertyListValue(derEncoded: node)
        }
    }

    @Test("Test ASN1 decoding error is wrapped in PropertyListValueError")
    func testASN1DecodingErrorWrapping() throws {
        // Create invalid DER structure with boolean that has invalid content
        let invalidBooleanDER: [UInt8] = [0x01, 0x02, 0xFF, 0xFF] // Boolean with length 2 (invalid)

        #expect(throws: (any Error).self) {
            let node = try DER.parse(invalidBooleanDER)
            _ = try PropertyListValue(derEncoded: node)
        }
    }
}
