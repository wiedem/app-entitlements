internal import Foundation
internal import MachO

extension MachO {
    static func segmentSectionData(
        of segment: UnsafePointer<segment_command>,
        sectionName name: String,
        slide: Int
    ) -> Data? {
        let sectionsStart = UnsafeRawPointer(segment.advanced(by: 1)).assumingMemoryBound(to: section.self)

        let sections = UnsafeBufferPointer(
            start: sectionsStart,
            count: Int(segment.pointee.nsects)
        )

        guard let section = sections.first(where: { section in
            sectionName(of: section) == name
        }) else {
            return nil
        }

        guard let dataPointer = UnsafeMutableRawPointer(bitPattern: Int(section.addr) + slide) else {
            return nil
        }

        return Data(
            bytesNoCopy: dataPointer,
            count: Int(section.size),
            deallocator: .none
        )
    }
}

extension MachO {
    static func segmentSectionData(
        of segment: UnsafePointer<segment_command_64>,
        sectionName name: String,
        slide: Int
    ) -> Data? {
        let sectionsStart = UnsafeRawPointer(segment.advanced(by: 1)).assumingMemoryBound(to: section_64.self)

        let sections = UnsafeBufferPointer(
            start: sectionsStart,
            count: Int(segment.pointee.nsects)
        )

        guard let section = sections.first(where: { section in
            sectionName(of: section) == name
        }) else {
            return nil
        }

        guard let dataPointer = UnsafeMutableRawPointer(bitPattern: Int(section.addr) + slide) else {
            return nil
        }

        return Data(
            bytesNoCopy: dataPointer,
            count: Int(section.size),
            deallocator: .none
        )
    }
}

func sectionName(of section: section) -> String {
    withUnsafePointer(to: section.sectname) { pointer in
        let cString = pointer.pointer(to: \.0)!
        return String(cString: cString)
    }
}

func sectionName(of section: section_64) -> String {
    withUnsafePointer(to: section.sectname) { pointer in
        let cString = pointer.pointer(to: \.0)!
        return String(cString: cString)
    }
}
