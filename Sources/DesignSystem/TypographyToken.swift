import Foundation

public enum TypographyToken: Sendable {
    case heading(Heading)
    case bodyBrand(BodyBrand)
    case bodySystem(BodySystem)
    case counter(Counter)
    case coach(Coach)
    case ui(UI)

    public enum Heading: String, CaseIterable, Sendable {
        case h1
        case h2
        case h3
        case h4Semi = "h4-semi"
        case h4
    }

    public enum BodyBrand: String, CaseIterable, Sendable {
        case lgRegular = "lg"
        case lgSemi = "lg-semi"
        case mdRegular = "md"
        case mdSemi = "md-semi"
        case smRegular = "sm"
        case smSemi = "sm-semi"
    }

    public enum BodySystem: String, CaseIterable, Sendable {
        case lgRegular = "lg"
        case lgSemi = "lg-semi"
        case mdRegular = "md"
        case mdSemi = "md-semi"
        case smRegular = "sm"
        case smSemi = "sm-semi"
    }

    public enum Counter: String, CaseIterable, Sendable {
        case xl
        case lg
        case md
        case sm
        case xs
        case bodySemi
    }

    public enum Coach: String, CaseIterable, Sendable {
        case chat
        case remark
        case name
    }

    public enum UI: String, CaseIterable, Sendable {
        case topBarSemi = "top-bar-semi"
        case topBar = "top-bar"
        case dailyInsightCardTitle = "daily-insight-card-title"
        case dailyInsightCardCategory = "daily-insight-card-category"
    }

    public init?(token: String) {
        guard let match = Self.allCases.first(where: { $0.token == token }) else {
            return nil
        }
        self = match
    }

    public static var allCases: [TypographyToken] {
        Heading.allCases.map { .heading($0) } +
        BodyBrand.allCases.map { .bodyBrand($0) } +
        BodySystem.allCases.map { .bodySystem($0) } +
        Counter.allCases.map { .counter($0) } +
        Coach.allCases.map { .coach($0) } +
        UI.allCases.map { .ui($0) }
    }

    public var token: String {
        switch self {
        case .heading(let token): "heading/\(token.rawValue)"
        case .bodyBrand(let token): "body/brand/\(token.rawValue)"
        case .bodySystem(let token): "body/system/\(token.rawValue)"
        case .counter(let token): "counter/\(token.rawValue)"
        case .coach(let token): "coach/\(token.rawValue)"
        case .ui(let token): "ui/\(token.rawValue)"
        }
    }
}
