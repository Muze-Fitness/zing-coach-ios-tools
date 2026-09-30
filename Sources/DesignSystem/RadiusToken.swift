import Foundation

public enum RadiusToken: Sendable {
    case button
    case input
    case hero
    case modal
    case card(Card)

    public enum Card: String, CaseIterable, Sendable {
        case sm
        case md
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
