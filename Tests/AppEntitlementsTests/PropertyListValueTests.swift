@testable import AppEntitlements
import Foundation
import Testing

struct PropertyListValueTests {
    @Test(
        "Test init from supported NSNumber type returns value",
        arguments: zip([
            NSNumber(value: Int32(1)),
            NSNumber(value: Int64(2)),
            NSNumber(value: Float32(1.1)),
            NSNumber(value: Double(2.2)),
            NSNumber(value: Bool(true)),
        ], [
            PropertyListValue.int32(1),
            PropertyListValue.int64(2),
            PropertyListValue.float(1.1),
            PropertyListValue.double(2.2),
            PropertyListValue.bool(true),
        ])
    )
    func initFromSupportedNSNumber(number: NSNumber, expected: PropertyListValue) {
        #expect(PropertyListValue(number) == expected)
    }

    @Test(
        "Test init from unsupported NSNumber type returns nil",
        arguments: [
            NSNumber(value: Int8(1)),
            NSNumber(value: Int16(2)),
        ]
    )
    func initFromUnsupportedNSNumber(number: NSNumber) {
        #expect(PropertyListValue(number) == nil)
    }

    @Test("Test init with property list array returns PropertyListValue array case")
    func initWithPropertyListArray() {
        let array: [Int32] = [1, 2, 3]
        #expect(PropertyListValue(array as Any) == .array([
            .int32(1),
            .int32(2),
            .int32(3),
        ]))
    }

    @Test("Test init with property list dictionary returns PropertyListValue dictionary case")
    func initWithPropertyListDictionary() {
        let dictionary: [String: Int32] = [
            "First": 1,
            "Second": 2,
            "Third": 3,
        ]

        #expect(PropertyListValue(dictionary as Any) == .dictionary([
            "First": .int32(1),
            "Second": .int32(2),
            "Third": .int32(3),
        ]))
    }

    @Test("Test init with decoded property list object returns PropertyListValue dictionary case")
    func initWithDecodedPropertyListObject() throws {
        let plistObject = try PropertyListSerialization.propertyList(from: Self.plistData, format: nil)
        let sut = PropertyListValue(plistObject)

        #expect(try sut == .dictionary([
            "StringValue": .string("String"),
            "NumberValue": .int64(1),
            "FloatValue": .double(1.2),
            "BoolValue": .bool(true),
            "DataValue": .data(Data([1, 2, 3, 4])),
            "DateValue": .date(#require(ISO8601DateFormatter().date(from: "2000-02-01T00:00:00Z"))),
            "ArrayValue": .array([
                .string("First"),
                .string("Second"),
            ]),
            "DictionaryValue": .dictionary([
                "FirstKey": .string("FirstValue"),
                "SecondKey": .string("SecondValue"),
            ]),
        ]))
    }
}

extension PropertyListValueTests {
    static let plistData = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>StringValue</key>
        <string>String</string>
        <key>NumberValue</key>
        <integer>1</integer>
        <key>FloatValue</key>            
        <real>1.2</real>
        <key>BoolValue</key>
        <true/>
        <key>DataValue</key>
        <data>
        AQIDBA==
        </data>
        <key>DateValue</key>
        <date>2000-02-01T00:00:00Z</date>
        <key>ArrayValue</key>
        <array>
            <string>First</string>
            <string>Second</string>
        </array>
        <key>DictionaryValue</key>
        <dict>
            <key>FirstKey</key>
            <string>FirstValue</string>
            <key>SecondKey</key>
            <string>SecondValue</string>
        </dict>
    </dict>
    </plist>
    """.data(using: .utf8)!
}
