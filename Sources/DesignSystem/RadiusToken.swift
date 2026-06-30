import Foundation

public enum RadiusToken: Sendable {
    /// Default: 16pt
    case button

    /// Default: 24pt
    case panel

    public init?(token: String) {
        guard let match = Self.allCases.first(where: { $0.token == token }) else {
            return nil
        }
        self = match
    }

    public static var allCases: [RadiusToken] {
        [.button]
    }

    public var token: String {
        switch self {
        case .button:
            return "radius/button"
        case .panel:
            return "radius/panel"
        }
    }
}
