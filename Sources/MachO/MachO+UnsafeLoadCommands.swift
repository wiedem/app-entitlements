internal import MachO

extension MachO {
    struct UnsafeLoadCommands: Sequence {
        private let commands: UnsafeRawPointer
        private let count: UInt32

        init(
            baseAddress commands: UnsafeRawPointer,
            count: UInt32
        ) {
            self.commands = commands
            self.count = count
        }

        func makeIterator() -> Iterator {
            Iterator(
                baseAddress: commands,
                count: count
            )
        }
    }
}

extension MachO.UnsafeLoadCommands {
    init(machHeader: UnsafePointer<mach_header>) {
        self.init(
            baseAddress: UnsafeRawPointer(machHeader.advanced(by: 1)),
            count: machHeader.pointee.ncmds
        )
    }

    init(machHeader: UnsafePointer<mach_header_64>) {
        self.init(
            baseAddress: UnsafeRawPointer(machHeader.advanced(by: 1)),
            count: machHeader.pointee.ncmds
        )
    }
}

extension MachO.UnsafeLoadCommands {
    struct Iterator: IteratorProtocol {
        private let commands: UnsafeRawPointer
        private let count: UInt32
        private var index = 0
        private var offset = 0

        init(
            baseAddress commands: UnsafeRawPointer,
            count: UInt32
        ) {
            self.commands = commands
            self.count = count
        }

        mutating func next() -> UnsafePointer<load_command>? {
            guard index < count else { return nil }

            let commandPointer = (commands + offset).assumingMemoryBound(to: load_command.self)
            offset += Int(commandPointer.pointee.cmdsize)
            index += 1
            return commandPointer
        }
    }
}
