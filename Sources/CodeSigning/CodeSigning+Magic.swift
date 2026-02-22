extension CodeSigning {
    enum Magic: UInt32 {
        case singleRequirement = 0xFADE_0C00
        case requirementsVector = 0xFADE_0C01
        case codeDirectory = 0xFADE_0C02
        case embeddedSignature = 0xFADE_0CC0
        case detachedSignature = 0xFADE_0CC1
        case signedData = 0xFADE_0B01
        case entitlement = 0xFADE_7171
        case entitlementDER = 0xFADE_7172
    }
}
