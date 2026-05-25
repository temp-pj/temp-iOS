import Models
import MusicKit

public struct MusicEntitlementClient: Sendable {
    public var requestAuthorization: @Sendable () async -> MusicAuthorization.Status
    public var checkEntitlement: @Sendable () async -> Bool
    
    public init(requestAuthorization: @Sendable @escaping () async -> MusicAuthorization.Status, checkEntitlement: @Sendable @escaping () async -> Bool) {
        self.requestAuthorization = requestAuthorization
        self.checkEntitlement = checkEntitlement
    }
}
