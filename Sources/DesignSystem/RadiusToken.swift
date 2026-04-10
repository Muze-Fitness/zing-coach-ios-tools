import Foundation

public enum RadiusToken: Sendable {
    public init?(token: String) {
        guard let match = Self.allCases.first(where: { $0.token == token }) else {
            return nil
        }
        self = match
    }

    public static var allCases: [RadiusToken] {
        []
    }

    public var token: String {
        switch self {
        }
    }
}
