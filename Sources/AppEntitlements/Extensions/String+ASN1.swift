internal import SwiftASN1

extension String {
    init(decoding utf8String: ASN1UTF8String) {
        self.init(
            decoding: utf8String.bytes,
            as: UTF8.self
        )
    }
}
