// MARK: - Push Notifications

/// The APNs environment.
public enum ApsEnvironment: String, Sendable {
    /// The APNs development environment.
    case development
    /// The APNs production environment.
    case production
}

extension ApsEnvironment: RawRepresentable {}

// MARK: - iCloud

/// The iCloud container environment.
public enum ICloudContainerEnvironment: String, Sendable {
    /// Development environment.
    case development = "Development"
    /// Production environment.
    case production = "Production"
}

extension ICloudContainerEnvironment: RawRepresentable {}

// MARK: - Device Check

/// The App Attest environment.
public enum AppAttestEnvironment: String, Sendable {
    /// The App Attest sandbox environment for testing.
    case development
    /// The App Attest production environment.
    case production
}

extension AppAttestEnvironment: RawRepresentable {}

// MARK: - iCloud Services

/// iCloud service types.
public enum ICloudService: String, Sendable {
    /// iCloud document storage.
    case cloudDocuments = "CloudDocuments"
    /// CloudKit database services.
    case cloudKit = "CloudKit"
    /// Anonymous CloudKit access (App Clips only).
    case cloudKitAnonymous = "CloudKit-Anonymous"
}

extension ICloudService: RawRepresentable {}
