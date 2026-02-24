internal import MachO

extension MachO {
    struct UnsafeLoadCommands: Sequence {
        private let commands: UnsafeRawPointer
        private let count: UInt32
        private let totalSize: UInt32

        init(
            baseAddress commands: UnsafeRawPointer,
            count: UInt32,
            totalSize: UInt32
        ) {
            self.commands = commands
            self.count = count
            self.totalSize = totalSize
        }

        func makeIterator() -> Iterator {
            Iterator(
                baseAddress: commands,
                count: count,
                totalSize: totalSize
            )
        }
    }
}

extension MachO.UnsafeLoadCommands {
    init(machHeader: UnsafePointer<mach_header>) {
        self.init(
            baseAddress: UnsafeRawPointer(machHeader.advanced(by: 1)),
            count: machHeader.pointee.ncmds,
            totalSize: machHeader.pointee.sizeofcmds
        )
    }

    init(machHeader: UnsafePointer<mach_header_64>) {
        self.init(
            baseAddress: UnsafeRawPointer(machHeader.advanced(by: 1)),
            count: machHeader.pointee.ncmds,
            totalSize: machHeader.pointee.sizeofcmds
        )
    }
}

extension MachO.UnsafeLoadCommands {
    struct Iterator: IteratorProtocol {
        private let commands: UnsafeRawPointer
        private let count: UInt32
        private let totalSize: UInt32
        private var index = 0
        private var offset = 0

        init(
            baseAddress commands: UnsafeRawPointer,
            count: UInt32,
            totalSize: UInt32
        ) {
            self.commands = commands
            self.count = count
            self.totalSize = totalSize
        }

        mutating func next() -> UnsafePointer<load_command>? {
            guard index < count else { return nil }

            let commandPointer = (commands + offset).assumingMemoryBound(to: load_command.self)
            let cmdsize = commandPointer.pointee.cmdsize

            // Validate minimum size (load_command struct is 8 bytes)
            guard cmdsize >= MemoryLayout<load_command>.size else {
                return nil
            }

            // Validate that command does not exceed total size
            guard offset + Int(cmdsize) <= Int(totalSize) else {
                return nil
            }

            offset += Int(cmdsize)
            index += 1
            return commandPointer
        }
    }
}
