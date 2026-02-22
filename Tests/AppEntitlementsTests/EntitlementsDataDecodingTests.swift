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
}
