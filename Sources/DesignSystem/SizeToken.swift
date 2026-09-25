import Foundation

public enum SizeToken: Sendable {
    case horizontal(Horizontal)
    case vertical(Vertical)

    public enum Horizontal: String, CaseIterable, Sendable {
        case screenMobile
        case betweenCards
        case betweenChips
    }

    public enum Vertical: String, CaseIterable, Sendable {
        case betweenText
        case betweenCards
        case textToComponent
        case betweenSections
        case betweenButtons
    }

    public init?(token: String) {
        guard let match = Self.allCases.first(where: { $0.token == token }) else {
            return nil
        }
        self = match
    }

    public static var allCases: [SizeToken] {
        Horizontal.allCases.map { .horizontal($0) } +
        Vertical.allCases.map { .vertical($0) }
    }

    public var token: String {
        switch self {
        case .horizontal(let token): "horizontal/\(token.rawValue)"
        case .vertical(let token): "vertical/\(token.rawValue)"
        }
    }
}
