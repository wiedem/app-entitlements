@testable import AppEntitlements
internal import Foundation
internal import MachO
internal import Testing

// MARK: - Shared Test Data Helpers

enum MachOTestData {
    static func dataFrom(_ value: some Any) -> Data {
        var value = value
        return withUnsafeBytes(of: &value) { Data($0) }
    }

    static func makeMachHeader64(ncmds: UInt32 = 0, sizeofcmds: UInt32 = 0) -> mach_header_64 {
        mach_header_64(
            magic: MH_MAGIC_64,
            cputype: 0,
            cpusubtype: 0,
            filetype: UInt32(MH_EXECUTE),
            ncmds: ncmds,
            sizeofcmds: sizeofcmds,
            flags: 0,
            reserved: 0
        )
    }

    static func makeMachHeader(ncmds: UInt32 = 0, sizeofcmds: UInt32 = 0) -> mach_header {
        mach_header(
            magic: MH_MAGIC,
            cputype: 0,
            cpusubtype: 0,
            filetype: UInt32(MH_EXECUTE),
            ncmds: ncmds,
            sizeofcmds: sizeofcmds,
            flags: 0
        )
    }

    static func makeLinkeditDataCommand(dataoff: UInt32, datasize: UInt32 = 0) -> linkedit_data_command {
        linkedit_data_command(
            cmd: UInt32(LC_CODE_SIGNATURE),
            cmdsize: UInt32(MemoryLayout<linkedit_data_command>.size),
            dataoff: dataoff,
            datasize: datasize
        )
    }

    /// Creates a load command as `Data`, zero-padded to `cmdsize` bytes.
    static func loadCommandData(cmd: UInt32, cmdsize: UInt32) -> Data {
        let command = load_command(cmd: cmd, cmdsize: cmdsize)
        var data = Data(count: max(Int(cmdsize), MemoryLayout<load_command>.size))
        data.replaceSubrange(0..<MemoryLayout<load_command>.size, with: dataFrom(command))
        return data
    }
}

// MARK: - UnsafeMachHeader Tests

struct MachOHeaderTests {
    @Test("Buffer too small for magic bytes throws truncatedData")
    func bufferTooSmallForMagic() throws {
        let data = Data([0x00, 0x01, 0x02]) // 3 bytes, need at least 4

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            #expect(throws: MachO.DataError.truncatedData) {
                _ = try MachO.UnsafeMachHeader(baseAddress: baseAddress, bufferSize: buffer.count)
            }
        }
    }

    @Test("Invalid magic throws invalidMachHeader")
    func invalidMagicThrows() throws {
        var data = Data(count: 32)
        data.withUnsafeMutableBytes { buffer in
            buffer.storeBytes(of: UInt32(0xDEAD_BEEF), as: UInt32.self)
        }

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            #expect(throws: MachO.DataError.invalidMachHeader) {
                _ = try MachO.UnsafeMachHeader(baseAddress: baseAddress, bufferSize: buffer.count)
            }
        }
    }

    @Test("Fat binary magic throws fatBinary")
    func fatBinaryMagicThrows() throws {
        var data = Data(count: 32)
        data.withUnsafeMutableBytes { buffer in
            buffer.storeBytes(of: FAT_CIGAM, as: UInt32.self)
        }

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            #expect(throws: MachO.DataError.fatBinary) {
                _ = try MachO.UnsafeMachHeader(baseAddress: baseAddress, bufferSize: buffer.count)
            }
        }
    }

    @Test("Buffer too small for mach_header_64 throws truncatedData")
    func bufferTooSmallForHeader64() throws {
        // Write valid 64-bit magic but only provide 16 bytes (mach_header_64 is 32 bytes)
        var data = Data(count: 16)
        data.withUnsafeMutableBytes { buffer in
            buffer.storeBytes(of: MH_MAGIC_64, as: UInt32.self)
        }

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            #expect(throws: MachO.DataError.truncatedData) {
                _ = try MachO.UnsafeMachHeader(baseAddress: baseAddress, bufferSize: buffer.count)
            }
        }
    }

    @Test("Buffer too small for mach_header throws truncatedData")
    func bufferTooSmallForHeader32() throws {
        // Write valid 32-bit magic but only provide 8 bytes (mach_header is 28 bytes)
        var data = Data(count: 8)
        data.withUnsafeMutableBytes { buffer in
            buffer.storeBytes(of: MH_MAGIC, as: UInt32.self)
        }

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            #expect(throws: MachO.DataError.truncatedData) {
                _ = try MachO.UnsafeMachHeader(baseAddress: baseAddress, bufferSize: buffer.count)
            }
        }
    }

    @Test("sizeofcmds exceeding buffer throws truncatedData")
    func sizeofcmdsExceedsBuffer() throws {
        let data = MachOTestData.dataFrom(MachOTestData.makeMachHeader64(ncmds: 1, sizeofcmds: 1000))

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            #expect(throws: MachO.DataError.truncatedData) {
                _ = try MachO.UnsafeMachHeader(baseAddress: baseAddress, bufferSize: buffer.count)
            }
        }
    }

    @Test("Valid mach_header_64 with zero commands succeeds")
    func validHeader64ZeroCommands() throws {
        let data = MachOTestData.dataFrom(MachOTestData.makeMachHeader64())

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            let header = try MachO.UnsafeMachHeader(baseAddress: baseAddress, bufferSize: buffer.count)
            #expect(header.headerMagic == .magic64)
        }
    }

    @Test("Valid mach_header_64 with commands fitting in buffer succeeds")
    func validHeader64WithCommands() throws {
        var data = MachOTestData.dataFrom(MachOTestData.makeMachHeader64(ncmds: 1, sizeofcmds: 16))
        data.append(MachOTestData.loadCommandData(cmd: UInt32(LC_SYMTAB), cmdsize: 16))

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            let header = try MachO.UnsafeMachHeader(baseAddress: baseAddress, bufferSize: buffer.count)
            #expect(header.headerMagic == .magic64)
        }
    }

    @Test("Valid 32-bit mach_header succeeds")
    func validHeader32() throws {
        let data = MachOTestData.dataFrom(MachOTestData.makeMachHeader())

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            let header = try MachO.UnsafeMachHeader(baseAddress: baseAddress, bufferSize: buffer.count)
            #expect(header.headerMagic == .magic)
        }
    }
}

// MARK: - UnsafeLoadCommands Iterator Tests

struct LoadCommandsIteratorTests {
    @Test("Iterator returns nil when totalSize is too small for a load_command")
    func totalSizeTooSmallForCommand() throws {
        let data = MachOTestData.loadCommandData(cmd: UInt32(LC_SYMTAB), cmdsize: 16)

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            let commands = MachO.UnsafeLoadCommands(
                baseAddress: baseAddress,
                count: 1,
                totalSize: 4 // too small for load_command header (8 bytes)
            )
            var iterator = commands.makeIterator()
            #expect(iterator.next() == nil)
        }
    }

    @Test("Iterator returns nil when cmdsize is below minimum")
    func cmdsizeBelowMinimum() throws {
        let data = MachOTestData.loadCommandData(cmd: UInt32(LC_SYMTAB), cmdsize: 4)

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            let commands = MachO.UnsafeLoadCommands(
                baseAddress: baseAddress,
                count: 1,
                totalSize: UInt32(buffer.count)
            )
            var iterator = commands.makeIterator()
            #expect(iterator.next() == nil)
        }
    }

    @Test("Iterator returns nil when cmdsize exceeds totalSize")
    func cmdsizeExceedsTotalSize() throws {
        let data = MachOTestData.loadCommandData(cmd: UInt32(LC_SYMTAB), cmdsize: 32)

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            let commands = MachO.UnsafeLoadCommands(
                baseAddress: baseAddress,
                count: 1,
                totalSize: 16
            )
            var iterator = commands.makeIterator()
            #expect(iterator.next() == nil)
        }
    }

    @Test("Iterator returns nil immediately for zero count")
    func zeroCountReturnsNil() throws {
        let data = Data(count: 16)

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            let commands = MachO.UnsafeLoadCommands(
                baseAddress: baseAddress,
                count: 0,
                totalSize: 16
            )
            var iterator = commands.makeIterator()
            #expect(iterator.next() == nil)
        }
    }

    @Test("Iterator correctly iterates multiple commands")
    func iteratesMultipleCommands() throws {
        var data = MachOTestData.loadCommandData(cmd: UInt32(LC_SYMTAB), cmdsize: 8)
        data.append(MachOTestData.loadCommandData(cmd: UInt32(LC_SEGMENT_64), cmdsize: 8))

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            let commands = MachO.UnsafeLoadCommands(
                baseAddress: baseAddress,
                count: 2,
                totalSize: 16
            )
            var iterator = commands.makeIterator()

            let first = iterator.next()
            let firstCommand = try #require(first)
            #expect(firstCommand.pointee.cmd == UInt32(LC_SYMTAB))

            let second = iterator.next()
            let secondCommand = try #require(second)
            #expect(secondCommand.pointee.cmd == UInt32(LC_SEGMENT_64))

            #expect(iterator.next() == nil)
        }
    }

    @Test("Iterator stops at second command when it exceeds totalSize")
    func stopsWhenSecondCommandExceedsBounds() throws {
        var data = MachOTestData.loadCommandData(cmd: UInt32(LC_SYMTAB), cmdsize: 8)
        data.append(MachOTestData.loadCommandData(cmd: UInt32(LC_SEGMENT_64), cmdsize: 24))

        try data.withUnsafeBytes { buffer in
            let baseAddress = try #require(buffer.baseAddress)
            let commands = MachO.UnsafeLoadCommands(
                baseAddress: baseAddress,
                count: 2,
                totalSize: 20 // only 12 bytes left for second command, but it claims 24
            )
            var iterator = commands.makeIterator()

            // First command succeeds
            let first = iterator.next()
            let firstCommand = try #require(first)
            #expect(firstCommand.pointee.cmd == UInt32(LC_SYMTAB))

            // Second command exceeds totalSize
            #expect(iterator.next() == nil)
        }
    }
}
