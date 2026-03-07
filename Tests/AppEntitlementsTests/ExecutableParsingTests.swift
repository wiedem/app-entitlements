@testable import AppEntitlements
internal import Foundation
internal import MachO
internal import Testing

struct ExecutableParsingTests {
    // MARK: - EntitlementsData.make(fromMachOFileData:bufferSize:)

    @Test("Buffer too small for mach header throws truncatedData")
    func bufferTooSmallForMachHeader() throws {
        let data = Data([0x00, 0x01, 0x02, 0x04])

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            #expect(throws: MachO.DataError.self) {
                _ = try AppEntitlements.EntitlementsData.make(
                    fromMachOFileData: baseAddress,
                    bufferSize: buffer.count
                )
            }
        }
    }

    @Test("Valid header without code signature returns empty entitlements")
    func noCodeSignatureReturnsEmpty() throws {
        let cmdsize = UInt32(MemoryLayout<load_command>.size)
        var data = MachOTestData.dataFrom(MachOTestData.makeMachHeader64(ncmds: 1, sizeofcmds: cmdsize))
        data.append(MachOTestData.loadCommandData(cmd: UInt32(LC_SYMTAB), cmdsize: cmdsize))

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            let entitlementsData = try AppEntitlements.EntitlementsData.make(
                fromMachOFileData: baseAddress,
                bufferSize: buffer.count
            )
            let result = try entitlementsData.decode()
            #expect(result.isEmpty)
        }
    }

    @Test("Code signature offset beyond buffer throws truncatedData")
    func codeSignatureOffsetBeyondBuffer() throws {
        let cmdsize = UInt32(MemoryLayout<linkedit_data_command>.size)
        var data = MachOTestData.dataFrom(MachOTestData.makeMachHeader64(ncmds: 1, sizeofcmds: cmdsize))
        data.append(MachOTestData.dataFrom(MachOTestData.makeLinkeditDataCommand(dataoff: 99999, datasize: 100)))

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            #expect(throws: MachO.DataError.truncatedData) {
                _ = try AppEntitlements.EntitlementsData.make(
                    fromMachOFileData: baseAddress,
                    bufferSize: buffer.count
                )
            }
        }
    }

    @Test("Code signature with truncated SuperBlob returns empty entitlements")
    func truncatedSuperBlobReturnsEmpty() throws {
        let cmdsize = UInt32(MemoryLayout<linkedit_data_command>.size)
        let headerSize = MemoryLayout<mach_header_64>.size
        let codeSignatureOffset = UInt32(headerSize) + cmdsize

        var data = MachOTestData.dataFrom(MachOTestData.makeMachHeader64(ncmds: 1, sizeofcmds: cmdsize))
        data.append(MachOTestData.dataFrom(MachOTestData.makeLinkeditDataCommand(dataoff: codeSignatureOffset, datasize: 4)))
        // Append only 4 bytes where a SuperBlob header (12 bytes) is expected
        data.append(Data(count: 4))

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            let entitlementsData = try AppEntitlements.EntitlementsData.make(
                fromMachOFileData: baseAddress,
                bufferSize: buffer.count
            )
            let result = try entitlementsData.decode()
            #expect(result.isEmpty)
        }
    }

    // MARK: - entitlements(fromExecutableAt:) public API

    @Test("Non-existent file throws error")
    func nonExistentFileThrows() throws {
        let url = URL(filePath: "/tmp/nonexistent-\(UUID().uuidString)")
        #expect(throws: AppEntitlements.EntitlementsError.self) {
            _ = try AppEntitlements.entitlements(fromExecutableAt: url)
        }
    }

    @Test("Empty file throws error")
    func emptyFileThrows() throws {
        let url = try Self.writeTempFile(data: Data())
        defer { try? FileManager.default.removeItem(at: url) }

        #expect(throws: AppEntitlements.EntitlementsError.self) {
            _ = try AppEntitlements.entitlements(fromExecutableAt: url)
        }
    }

    @Test("File smaller than mach_header throws error")
    func fileSmallerThanMachHeaderThrows() throws {
        let url = try Self.writeTempFile(data: Data([0x01, 0x02, 0x03]))
        defer { try? FileManager.default.removeItem(at: url) }

        #expect(throws: AppEntitlements.EntitlementsError.self) {
            _ = try AppEntitlements.entitlements(fromExecutableAt: url)
        }
    }

    @Test("File with invalid magic throws error")
    func fileWithInvalidMagicThrows() throws {
        let data = MachOTestData.dataFrom(UInt32(0xDEAD_BEEF)) + Data(count: 60)
        let url = try Self.writeTempFile(data: data)
        defer { try? FileManager.default.removeItem(at: url) }

        #expect(throws: AppEntitlements.EntitlementsError.self) {
            _ = try AppEntitlements.entitlements(fromExecutableAt: url)
        }
    }
}

// MARK: - Test Helpers

private extension ExecutableParsingTests {
    static func writeTempFile(data: Data) throws -> URL {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent("appentitlements-test-\(UUID().uuidString)")
        try data.write(to: url)
        return url
    }
}
