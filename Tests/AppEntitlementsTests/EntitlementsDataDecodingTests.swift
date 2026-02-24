@testable import AppEntitlements
internal import Foundation
internal import Testing

struct EntitlementsDataDecodingTests {
    @Test("Test DER takes precedence over PropertyList")
    func testDERPrecedenceOverPropertyList() throws {
        // Use existing valid DER data from DEREncodedTests
        let derData = Data(base64Encoded:
            """
            cIIBIAIBAbCCARkwMAwWYXBwbGljYXRpb24taWRlbnRpZmllcgwWVEVBTUlELmNv\
            bS5leGFtcGxlLmFwcDBYDBZrZXljaGFpbi1hY2Nlc3MtZ3JvdXBzMD4MHVRFQU1J\
            RC5jb20uZXhhbXBsZS5hcHAuZ3JvdXAxDB1URUFNSUQuY29tLmV4YW1wbGUuYXBw\
            Lmdyb3VwMjBHDCtjb20uYXBwbGUuZGV2ZWxvcGVyLmRlZmF1bHQtZGF0YS1wcm90\
            ZWN0aW9uDBhOU0ZpbGVQcm90ZWN0aW9uQ29tcGxldGUwLQwjY29tLmFwcGxlLmRl\
            dmVsb3Blci50ZWFtLWlkZW50aWZpZXIMBlRFQU1JRDATDA5nZXQtdGFzay1hbGxv\
            dwEB/w==
            """)!

        // Create PropertyList data with different value for same key
        let plistData = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>application-identifier</key>
            <string>PLIST.VALUE</string>
            <key>get-task-allow</key>
            <false/>
        </dict>
        </plist>
        """.data(using: .utf8)!

        let entitlementsData = AppEntitlements.EntitlementsData(
            linkEditData: plistData,
            linkEditDataDER: derData,
            textSectionData: nil
        )

        let decoded = try entitlementsData.decode()

        // DER value should win
        #expect(decoded["application-identifier"]?.stringValue == "TEAMID.com.example.app")
        #expect(decoded["get-task-allow"]?.boolValue == true)
    }

    @Test("Test PropertyList values without DER override")
    func testPropertyListWithoutDEROverride() throws {
        let plistData = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>application-identifier</key>
            <string>PLIST.VALUE</string>
            <key>unique-plist-key</key>
            <string>UNIQUE</string>
        </dict>
        </plist>
        """.data(using: .utf8)!

        // Use valid DER data from DEREncodedTests
        let derData = Data(base64Encoded:
            """
            cIIBIAIBAbCCARkwMAwWYXBwbGljYXRpb24taWRlbnRpZmllcgwWVEVBTUlELmNv\
            bS5leGFtcGxlLmFwcDBYDBZrZXljaGFpbi1hY2Nlc3MtZ3JvdXBzMD4MHVRFQU1J\
            RC5jb20uZXhhbXBsZS5hcHAuZ3JvdXAxDB1URUFNSUQuY29tLmV4YW1wbGUuYXBw\
            Lmdyb3VwMjBHDCtjb20uYXBwbGUuZGV2ZWxvcGVyLmRlZmF1bHQtZGF0YS1wcm90\
            ZWN0aW9uDBhOU0ZpbGVQcm90ZWN0aW9uQ29tcGxldGUwLQwjY29tLmFwcGxlLmRl\
            dmVsb3Blci50ZWFtLWlkZW50aWZpZXIMBlRFQU1JRDATDA5nZXQtdGFzay1hbGxv\
            dwEB/w==
            """)!

        let entitlementsData = AppEntitlements.EntitlementsData(
            linkEditData: plistData,
            linkEditDataDER: derData,
            textSectionData: nil
        )

        let decoded = try entitlementsData.decode()

        // DER overrides application-identifier
        #expect(decoded["application-identifier"]?.stringValue == "TEAMID.com.example.app")

        // Unique PropertyList key remains
        #expect(decoded["unique-plist-key"]?.stringValue == "UNIQUE")

        // DER-only key exists
        #expect(decoded["get-task-allow"]?.boolValue == true)
    }

    @Test("Test text section fallback when LINKEDIT unavailable")
    func testTextSectionFallback() throws {
        let textSectionData = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>application-identifier</key>
            <string>TEXT.SECTION</string>
        </dict>
        </plist>
        """.data(using: .utf8)!

        let entitlementsData = AppEntitlements.EntitlementsData(
            linkEditData: nil,
            linkEditDataDER: nil,
            textSectionData: textSectionData
        )

        let decoded = try entitlementsData.decode()

        #expect(decoded["application-identifier"]?.stringValue == "TEXT.SECTION")
    }

    @Test("Test LINKEDIT takes precedence over text section")
    func testLinkEditPrecedenceOverTextSection() throws {
        let linkEditData = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>application-identifier</key>
            <string>LINKEDIT.VALUE</string>
        </dict>
        </plist>
        """.data(using: .utf8)!

        let textSectionData = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>application-identifier</key>
            <string>TEXT.VALUE</string>
        </dict>
        </plist>
        """.data(using: .utf8)!

        let entitlementsData = AppEntitlements.EntitlementsData(
            linkEditData: linkEditData,
            linkEditDataDER: nil,
            textSectionData: textSectionData
        )

        let decoded = try entitlementsData.decode()

        // LINKEDIT should win over text section
        #expect(decoded["application-identifier"]?.stringValue == "LINKEDIT.VALUE")
    }

    @Test("Test empty entitlements returns empty dictionary")
    func testEmptyEntitlementsReturnsEmptyDictionary() throws {
        let entitlementsData = AppEntitlements.EntitlementsData.none

        let decoded = try entitlementsData.decode()

        #expect(decoded.isEmpty)
    }

    @Test("Test invalid PropertyList format throws unexpectedFormat error")
    func testInvalidPropertyListFormatThrowsError() throws {
        // PropertyList with array at root instead of dictionary
        let invalidPlistData = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <array>
            <string>not-a-dictionary</string>
        </array>
        </plist>
        """.data(using: .utf8)!

        let entitlementsData = AppEntitlements.EntitlementsData(
            linkEditData: invalidPlistData,
            linkEditDataDER: nil,
            textSectionData: nil
        )

        #expect(throws: AppEntitlements.EntitlementsError.self) {
            _ = try entitlementsData.decode()
        }
    }

    @Test("Test partial success with one valid and one invalid source")
    func testPartialSuccessReturnsValidData() throws {
        // Valid PropertyList
        let validPlistData = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>valid-key</key>
            <string>VALID</string>
        </dict>
        </plist>
        """.data(using: .utf8)!

        // Invalid PropertyList (array instead of dict)
        let invalidPlistData = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <array>
            <string>invalid</string>
        </array>
        </plist>
        """.data(using: .utf8)!

        let entitlementsData = AppEntitlements.EntitlementsData(
            linkEditData: validPlistData,
            linkEditDataDER: nil,
            textSectionData: invalidPlistData
        )

        // Should succeed with valid data despite one source failing
        let decoded = try entitlementsData.decode()

        #expect(decoded["valid-key"]?.stringValue == "VALID")
    }

    @Test("Test all sources fail throws first error")
    func testAllSourcesFailThrowsFirstError() throws {
        // Invalid PropertyList 1
        let invalidPlist1 = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <array>
            <string>invalid1</string>
        </array>
        </plist>
        """.data(using: .utf8)!

        // Invalid PropertyList 2
        let invalidPlist2 = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <string>also-invalid</string>
        </plist>
        """.data(using: .utf8)!

        let entitlementsData = AppEntitlements.EntitlementsData(
            linkEditData: invalidPlist1,
            linkEditDataDER: nil,
            textSectionData: invalidPlist2
        )

        // Should throw the first error encountered
        #expect(throws: AppEntitlements.EntitlementsError.self) {
            _ = try entitlementsData.decode()
        }
    }

    @Test("Test DER decode error is caught and other sources still processed")
    func testDERErrorDoesNotPreventOtherSources() throws {
        // Valid PropertyList
        let validPlistData = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>plist-key</key>
            <string>FROM_PLIST</string>
        </dict>
        </plist>
        """.data(using: .utf8)!

        // Invalid DER data (just random bytes)
        let invalidDERData = Data([0xFF, 0xFE, 0xFD, 0xFC])

        let entitlementsData = AppEntitlements.EntitlementsData(
            linkEditData: validPlistData,
            linkEditDataDER: invalidDERData,
            textSectionData: nil
        )

        // Should succeed with PropertyList data despite DER failing
        let decoded = try entitlementsData.decode()

        #expect(decoded["plist-key"]?.stringValue == "FROM_PLIST")
    }
}
