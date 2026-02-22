internal import AppEntitlementsCore
internal import AppEntitlementsMacros

public enum ApsEnvironment: String, Sendable {
    /// The APNs development environment.
    case development
    /// The APNs production environment.
    case production
}

public enum ClassKitEnvironment: String, Sendable {
    /// The environment used to develop and test your app locally, without requiring a Managed Apple ID issued by an educational institution.
    case development
    /// The environment used by customers of your app who have a Managed Apple ID. This enviroment enables teachers and students to share data through iCloud.
    case production
}

public enum ICloudContainerEnvironment: String, Sendable {
    case development = "Development"
    case production = "Production"
}
