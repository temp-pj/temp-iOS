import Models

public struct AuthClient: Sendable {
    public var login: @Sendable (LoginCredentials) async throws -> AuthSession
    public var logout: @Sendable () async throws -> Void
    
    public init(login: @escaping @Sendable (LoginCredentials) async throws -> AuthSession, logout: @escaping @Sendable () async throws -> Void) {
        self.login = login
        self.logout = logout
    }
}
