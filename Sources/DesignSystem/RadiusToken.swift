import Foundation

public enum RadiusToken: Sendable {
    /// Default: 16pt
    case button
    /// Default: 20pt
    case input
    /// Default: 32pt
    case hero
    /// Default: 48pt
    case modal
    case card(Card)

    public enum Card: String, CaseIterable, Sendable {
        /// Default: 8pt
        case sm
        /// Default: 16pt
        case md
        /// Default: 24pt
        case lg
    }

    public init?(token: String) {
        guard let match = Self.allCases.first(where: { $0.token == token }) else {
            return nil
        }
        self = match
    }

    public static var allCases: [RadiusToken] {
        [.button, .input, .hero, .modal] +
        Card.allCases.map { .card($0) }
    }

    public var token: String {
        switch self {
        case .button:
            return "radius/button"
        case .input:
            return "radius/input"
        case .hero:
            return "radius/hero"
        case .modal:
            return "radius/modal"
        case .card(let token):
            return "radius/card-\(token.rawValue)"
        }
    }
}
