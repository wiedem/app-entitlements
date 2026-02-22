internal import Foundation
private import MachO

public extension AppEntitlements {
    static let mainProgramValues = Result<[String: PropertyListValue], EntitlementsError> { () throws(EntitlementsError) in
        // Open the main app MachO file with RTLD_DEFAULT.
        guard let mainProgramHandle = dlopen(nil, RTLD_LAZY) else {
            let errorDescriptionPointer = dlerror()!
            throw EntitlementsError.failedToLoadLibrary(
                String(cString: errorDescriptionPointer)
            )
        }
        defer {
            dlclose(mainProgramHandle)
        }

        // Get a pointer to the MachO header.
        guard let machHeaderPointer = dlsym(mainProgramHandle, MH_EXECUTE_SYM) else {
            let errorDescriptionPointer = dlerror()!
            throw EntitlementsError.failedToLoadExecutableSymbol(
                String(cString: errorDescriptionPointer)
            )
        }

        // Process the MachO header and decode entitlements
        // This part can throw other errors (MachO.DataError, PropertyListValueError, DEREncodingError)
        do {
            let machHeader = try MachO.UnsafeMachHeader(baseAddress: machHeaderPointer)
            let entitlementsData = EntitlementsData.make(from: machHeader)
            return try entitlementsData.decode()
        } catch {
            // Wrap all non-EntitlementsError errors
            throw EntitlementsError.failedToReadEntitlements(error)
        }
    }
}
