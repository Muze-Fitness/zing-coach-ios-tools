import Foundation

public enum SizeToken: Sendable {
    case horizontal(Horizontal)
    case vertical(Vertical)

    public enum Horizontal: String, CaseIterable, Sendable {
        /// Default: 24pt
        case screenMobile
        /// Default: 8pt
        case betweenCards
        /// Default: 4pt
        case betweenChips
    }

    public enum Vertical: String, CaseIterable, Sendable {
        /// Default: 8pt
        case betweenText
        /// Default: 8pt
        case betweenCards
        /// Default: 24pt
        case textToComponent
        /// Default: 40pt
        case betweenSections
        /// Default: 8pt
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
