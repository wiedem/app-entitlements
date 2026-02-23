private import MachO

extension MachO {
    enum HeaderMagic: UInt32 {
        case magic
        case magic64
        case fat
        case fat64
    }
}

extension MachO.HeaderMagic {
    var rawValue: UInt32 {
        switch self {
        case .magic:
            MH_MAGIC
        case .magic64:
            MH_MAGIC_64
        case .fat:
            FAT_CIGAM
        case .fat64:
            FAT_CIGAM_64
        }
    }

    init?(rawValue: UInt32) {
        switch rawValue {
        case MH_MAGIC:
            self = .magic
        case MH_MAGIC_64:
            self = .magic64
        case FAT_CIGAM:
            self = .fat
        case FAT_CIGAM_64:
            self = .fat64
        default:
            return nil
        }
    }
}
