@testable import AppEntitlements
import Foundation
import Testing

struct DEREncodedTests {
    @Test("Test decoding valid DER encoded entitlements succeeds")
    func decodeValidDEREncodedValuesSucceeds() throws {
        let entitlements = try AppEntitlements.DEREncoded(
            derEncoded: Array(Self.entitlementsDER)
        )

        #expect(entitlements.values == [
            "application-identifier": .string("TEAMID.com.example.app"),
            "com.apple.developer.default-data-protection": .string("NSFileProtectionComplete"),
            "com.apple.developer.team-identifier": .string("TEAMID"),
            "get-task-allow": .bool(true),
            "keychain-access-groups": .array([
                .string("TEAMID.com.example.app.group1"),
                .string("TEAMID.com.example.app.group2"),
            ]),
        ])
    }
}

private extension DEREncodedTests {
    static let entitlementsDER = Data(base64Encoded:
        """
        cIIBIAIBAbCCARkwMAwWYXBwbGljYXRpb24taWRlbnRpZmllcgwWVEVBTUlELmNv\
        bS5leGFtcGxlLmFwcDBYDBZrZXljaGFpbi1hY2Nlc3MtZ3JvdXBzMD4MHVRFQU1J\
        RC5jb20uZXhhbXBsZS5hcHAuZ3JvdXAxDB1URUFNSUQuY29tLmV4YW1wbGUuYXBw\
        Lmdyb3VwMjBHDCtjb20uYXBwbGUuZGV2ZWxvcGVyLmRlZmF1bHQtZGF0YS1wcm90\
        ZWN0aW9uDBhOU0ZpbGVQcm90ZWN0aW9uQ29tcGxldGUwLQwjY29tLmFwcGxlLmRl\
        dmVsb3Blci50ZWFtLWlkZW50aWZpZXIMBlRFQU1JRDATDA5nZXQtdGFzay1hbGxv\
        dwEB/w==
        """)!
}
