@testable import AppEntitlements
internal import Foundation
internal import Testing

struct CodeSigningBlobTests {
    @Test("Test SuperBlob with valid entitlement blobs")
    func superBlobWithEntitlementBlobs() throws {
        // Create a valid SuperBlob structure in memory
        let blobData = Self.createSuperBlobData()

        try blobData.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)

            let superBlob = try #require(CodeSigning.UnsafeSuperBlob(baseAddress: baseAddress))
            #expect(superBlob.magic == .embeddedSignature)
            #expect(superBlob.blobs.count == 2)

            // Check for entitlement blob
            let entitlementBlob = try #require(superBlob.blobs.first(where: { $0.magic == .entitlement }))
            #expect(entitlementBlob.blobData.count > 0)

            // Check for DER entitlement blob
            let derBlob = try #require(superBlob.blobs.first(where: { $0.magic == .entitlementDER }))
            #expect(derBlob.blobData.count > 0)
        }
    }

    @Test("Test SuperBlob rejects invalid magic number")
    func superBlobRejectsInvalidMagic() throws {
        var invalidData = Data(count: 12)
        invalidData.withUnsafeMutableBytes { buffer in
            buffer.storeBytes(of: UInt32(0xDEAD_BEEF).bigEndian, as: UInt32.self)
        }

        try invalidData.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)

            let superBlob = CodeSigning.UnsafeSuperBlob(baseAddress: baseAddress)
            #expect(superBlob == nil)
        }
    }

    @Test("Test Blob with valid magic and data")
    func blobWithValidMagicAndData() throws {
        let testData = "test-entitlement-data".data(using: .utf8)!
        let blobData = Self.createBlobData(magic: 0xFADE_7171, data: testData)

        try blobData.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)

            let blob = try #require(CodeSigning.UnsafeBlob(baseAddress: baseAddress))
            #expect(blob.magic == .entitlement)
            #expect(blob.blobData == testData)
        }
    }

    @Test("Test Blob rejects invalid magic number")
    func blobRejectsInvalidMagic() throws {
        var invalidData = Data(count: 8)
        invalidData.withUnsafeMutableBytes { buffer in
            buffer.storeBytes(of: UInt32(0xBADB_AD00).bigEndian, as: UInt32.self)
        }

        try invalidData.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)

            let blob = CodeSigning.UnsafeBlob(baseAddress: baseAddress)
            #expect(blob == nil)
        }
    }

    // MARK: - UnsafeBlob with containerSize

    @Test("Blob with containerSize smaller than header returns nil")
    func blobContainerTooSmallForHeader() throws {
        let testData = "test".data(using: .utf8)!
        let blobData = Self.createBlobData(magic: 0xFADE_7171, data: testData)

        try blobData.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            // containerSize of 4 is less than Blob Header (8 bytes)
            let blob = CodeSigning.UnsafeBlob(baseAddress: baseAddress, containerSize: 4)
            #expect(blob == nil)
        }
    }

    @Test("Blob with blobLength exceeding containerSize returns nil")
    func blobLengthExceedsContainer() throws {
        let testData = "test-entitlement-data".data(using: .utf8)!
        let blobData = Self.createBlobData(magic: 0xFADE_7171, data: testData)

        try blobData.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            // containerSize is 10, but blobLength is 8 + 21 = 29
            let blob = CodeSigning.UnsafeBlob(baseAddress: baseAddress, containerSize: 10)
            #expect(blob == nil)
        }
    }

    @Test("Blob with valid containerSize succeeds")
    func blobValidContainerSize() throws {
        let testData = "test".data(using: .utf8)!
        let blobData = Self.createBlobData(magic: 0xFADE_7171, data: testData)

        try blobData.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            let blob = try #require(
                CodeSigning.UnsafeBlob(baseAddress: baseAddress, containerSize: buffer.count)
            )
            #expect(blob.magic == .entitlement)
            #expect(blob.blobData == testData)
        }
    }

    // MARK: - UnsafeSuperBlob with containerSize

    @Test("SuperBlob with containerSize smaller than header returns nil")
    func superBlobContainerTooSmallForHeader() throws {
        let blobData = Self.createSuperBlobData()

        try blobData.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            // containerSize of 8 is less than SuperBlob Header (12 bytes)
            let superBlob = CodeSigning.UnsafeSuperBlob(baseAddress: baseAddress, containerSize: 8)
            #expect(superBlob == nil)
        }
    }

    @Test("SuperBlob with indices exceeding containerSize returns nil")
    func superBlobIndicesExceedContainer() throws {
        let blobData = Self.createSuperBlobData()

        try blobData.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            // containerSize of 14: fits header (12) but not 2 indices (2 * 8 = 16 more needed)
            let superBlob = CodeSigning.UnsafeSuperBlob(baseAddress: baseAddress, containerSize: 14)
            #expect(superBlob == nil)
        }
    }

    @Test("SuperBlob with blob offset beyond containerSize filters out blob")
    func superBlobBlobOffsetBeyondContainer() throws {
        // Create a SuperBlob where the second blob's offset is beyond the container
        let blobData = Self.createSuperBlobData()

        try blobData.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            // Use a containerSize that includes header + indices + first blob, but not the second
            // Header: 12, indices: 16, first blob: 8 + 17 = 25
            let containerSize = 12 + 16 + 25
            let superBlob = try #require(
                CodeSigning.UnsafeSuperBlob(baseAddress: baseAddress, containerSize: containerSize)
            )
            // Only the first blob should be present; the second is beyond bounds
            #expect(superBlob.blobs.count == 1)
            #expect(superBlob.blobs[0].magic == .entitlement)
        }
    }

    @Test("SuperBlob with valid containerSize returns all blobs")
    func superBlobValidContainerSize() throws {
        let blobData = Self.createSuperBlobData()

        try blobData.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            let superBlob = try #require(
                CodeSigning.UnsafeSuperBlob(baseAddress: baseAddress, containerSize: buffer.count)
            )
            #expect(superBlob.magic == .embeddedSignature)
            #expect(superBlob.blobs.count == 2)
        }
    }

    // MARK: - BigEndian byte order

    @Test("Test BigEndian byte order conversion")
    func bigEndianByteOrder() throws {
        // Test that magic numbers are correctly converted from BigEndian
        let magic = UInt32(0xFADE_0CC0)
        let blobData = Self.createBlobData(magic: magic, data: Data())

        try blobData.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)

            // Read raw bytes
            let rawMagic = baseAddress.load(as: UInt32.self)

            // Verify BigEndian encoding
            #expect(rawMagic == magic.bigEndian)

            // Verify blob correctly decodes it
            let blob = try #require(CodeSigning.UnsafeBlob(baseAddress: baseAddress))
            #expect(blob.magic == .embeddedSignature)
        }
    }
}

// MARK: - Test Data Helpers

private extension CodeSigningBlobTests {
    // Creates a valid SuperBlob structure with entitlement blobs
    static func createSuperBlobData() -> Data {
        var data = Data()

        // SuperBlob Header
        let magic = UInt32(0xFADE_0CC0).bigEndian // embeddedSignature
        let entitlementBlobData = "entitlement-plist".data(using: .utf8)!
        let derBlobData = "entitlement-der".data(using: .utf8)!

        // Calculate offsets and sizes
        let headerSize = 12 // magic + length + count
        let indexSize = 8 // type + offset per index
        let indicesSize = indexSize * 2

        let blob1Offset = headerSize + indicesSize
        let blob1Size = 8 + entitlementBlobData.count // header + data
        let blob2Offset = blob1Offset + blob1Size
        let blob2Size = 8 + derBlobData.count

        let totalLength = UInt32(blob2Offset + blob2Size).bigEndian
        let count = UInt32(2).bigEndian

        // Write SuperBlob header
        data.append(contentsOf: withUnsafeBytes(of: magic) { Data($0) })
        data.append(contentsOf: withUnsafeBytes(of: totalLength) { Data($0) })
        data.append(contentsOf: withUnsafeBytes(of: count) { Data($0) })

        // Write blob indices
        // Index 1: Entitlement blob
        data.append(contentsOf: withUnsafeBytes(of: UInt32(0x0005).bigEndian) { Data($0) }) // type
        data.append(contentsOf: withUnsafeBytes(of: UInt32(blob1Offset).bigEndian) { Data($0) })

        // Index 2: DER blob
        data.append(contentsOf: withUnsafeBytes(of: UInt32(0x0007).bigEndian) { Data($0) }) // type
        data.append(contentsOf: withUnsafeBytes(of: UInt32(blob2Offset).bigEndian) { Data($0) })

        // Write entitlement blob
        let blob1Magic = UInt32(0xFADE_7171).bigEndian
        let blob1Length = UInt32(blob1Size).bigEndian
        data.append(contentsOf: withUnsafeBytes(of: blob1Magic) { Data($0) })
        data.append(contentsOf: withUnsafeBytes(of: blob1Length) { Data($0) })
        data.append(entitlementBlobData)

        // Write DER blob
        let blob2Magic = UInt32(0xFADE_7172).bigEndian
        let blob2Length = UInt32(blob2Size).bigEndian
        data.append(contentsOf: withUnsafeBytes(of: blob2Magic) { Data($0) })
        data.append(contentsOf: withUnsafeBytes(of: blob2Length) { Data($0) })
        data.append(derBlobData)

        return data
    }

    // Creates a single blob with given magic and data
    static func createBlobData(magic: UInt32, data: Data) -> Data {
        var result = Data()

        let blobMagic = magic.bigEndian
        let blobLength = UInt32(8 + data.count).bigEndian

        result.append(contentsOf: withUnsafeBytes(of: blobMagic) { Data($0) })
        result.append(contentsOf: withUnsafeBytes(of: blobLength) { Data($0) })
        result.append(data)

        return result
    }
}
