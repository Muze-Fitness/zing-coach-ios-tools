import Foundation

public enum RadiusToken: Sendable {
    case button(Button)

    public enum Button: String, CaseIterable, Sendable {
        /// Default: 16pt
        case border
    }

    public init?(token: String) {
        guard let match = Self.allCases.first(where: { $0.token == token }) else {
            return nil
        }
        self = match
    }

    public static var allCases: [RadiusToken] {
        Button.allCases.map { .button($0) }
    }

    public var token: String {
        switch self {
        case .button(let token):
            return "button/\(token.rawValue)"
        }
    }
}
