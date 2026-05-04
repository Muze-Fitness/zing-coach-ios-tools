import Foundation

public enum TypographyToken: Sendable {
    case heading(Heading)
    case bodyBrand(BodyBrand)
    case bodySystem(BodySystem)
    case counter(Counter)
    case coach(Coach)
    case ui(UI)

    public enum Heading: String, CaseIterable, Sendable {
        /// Default: Outfit SemiBold 40pt, line height 1.1x, spacing +0.148
        case h1
        /// Default: Outfit SemiBold 32pt, line height 1.15x, spacing +0.13
        case h2
        /// Default: Outfit SemiBold 24pt, line height 1.2x, spacing +0.017
        case h3
        /// Default: SF Pro Display Semibold 12pt, line height 1.35x, spacing +0.148
        case h4Semi = "h4-semi"
        /// Default: SF Pro Display Regular 12pt, line height 1.35x, spacing +0.148
        case h4
    }

    public enum BodyBrand: String, CaseIterable, Sendable {
        /// Default: Brand Regular 18pt, line height 1.45x, spacing -0.056
        case lgRegular = "lg"
        /// Default: Brand SemiBold 18pt, line height 1.45x, spacing -0.056
        case lgSemi = "lg-semi"
        /// Default: Brand Regular 16pt, line height 1.4x, spacing -0.05
        case mdRegular = "md"
        /// Default: Brand SemiBold 16pt, line height 1.4x, spacing -0.05
        case mdSemi = "md-semi"
        /// Default: Brand Regular 12pt, line height 1.5x, spacing 0
        case smRegular = "sm"
        /// Default: Brand SemiBold 12pt, line height 1.5x, spacing 0
        case smSemi = "sm-semi"
    }

    public enum BodySystem: String, CaseIterable, Sendable {
        /// Default: SF Pro Display Regular 18pt, line height 1.45x, spacing -0.056
        case lgRegular = "lg"
        /// Default: SF Pro Display Semibold 18pt, line height 1.45x, spacing -0.056
        case lgSemi = "lg-semi"
        /// Default: SF Pro Display Regular 16pt, line height 1.4x, spacing -0.05
        case mdRegular = "md"
        /// Default: SF Pro Display Semibold 16pt, line height 1.4x, spacing -0.05
        case mdSemi = "md-semi"
        /// Default: SF Pro Display Regular 12pt, line height 1.5x, spacing 0
        case smRegular = "sm"
        /// Default: SF Pro Display Semibold 12pt, line height 1.5x, spacing 0
        case smSemi = "sm-semi"
    }

    public enum Counter: String, CaseIterable, Sendable {
        /// Default: Outfit SemiBold 160pt, line height 1.0x, spacing +1.2, monospaced digits
        case lg
        /// Default: Outfit SemiBold 80pt, line height 1.0x, spacing +0.6, monospaced digits
        case md
        /// Default: Outfit SemiBold 60pt, line height 1.0x, spacing +0.156, monospaced digits
        case sm
        /// Default: Outfit SemiBold 32pt, line height 1.0x, spacing +0.156, monospaced digits
        case xs
        /// Default: Outfit SemiBold 16pt, line height 1.4x, spacing +0.156, monospaced digits
        case bodySemi
    }

    public enum Coach: String, CaseIterable, Sendable {
        /// Default: SF Pro Display Regular 17pt, line height 1.3x, spacing 0
        case chat
        /// Default: SF Pro Display Medium 15pt, line height 1.2x, spacing -0.05
        case remark
        /// Default: Outfit SemiBold 12pt, line height 1.35x, spacing +0.148
        case name
    }

    public enum UI: String, CaseIterable, Sendable {
        /// Default: SF Pro Display Semibold 17pt, line height 1.1x, spacing -0.41
        case topBarSemi = "top-bar-semi"
        /// Default: SF Pro Display Regular 17pt, line height 1.1x, spacing -0.41
        case topBar = "top-bar"
        /// Default: SF Pro Display Medium 13pt, line height 1.2x, spacing -0.41
        case dailyInsightCardTitle = "daily-insight-card-title"
        /// Default: SF Pro Display Medium 10pt, line height 1.6x, spacing -0.41
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
