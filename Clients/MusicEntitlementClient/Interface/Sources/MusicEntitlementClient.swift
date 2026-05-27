import Models
import MusicKit

public struct MusicEntitlementClient: Sendable {
    public var authorizationStatus: @Sendable () -> MusicAuthorization.Status
    public var requestAuthorization: @Sendable () async -> MusicAuthorization.Status
    public var checkEntitlement: @Sendable () async -> Bool
    
    public init(
        authorizationStatus: @Sendable @escaping () -> MusicAuthorization.Status,
        requestAuthorization: @Sendable @escaping () async -> MusicAuthorization.Status,
        checkEntitlement: @Sendable @escaping () async -> Bool) {
            
            self.authorizationStatus = authorizationStatus
            self.requestAuthorization = requestAuthorization
            self.checkEntitlement = checkEntitlement
        }
}
