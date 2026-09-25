import Foundation

public enum ColorToken: Sendable {
    case bg(Bg)
    case border(Border)
    case brand(Brand)
    case button(Button)
    case cardBackground(CardBackground)
    case cv(CV)
    case fg(Fg)
    case heading(Heading)
    case overlay(Overlay)
    case overlayCard(OverlayCard)
    case textBody(TextBody)

    public enum Bg: String, CaseIterable, Sendable {
        case primary
        case secondary
        case tertiary
        case light
        case light24 = "light-24"
        case light64 = "light-64"
        case light8 = "light-8"
        case accentLayer = "accent-layer"
    }

    public enum Border: String, CaseIterable, Sendable {
        case primary
        case secondary
        case gloss
    }

    public enum Brand: String, CaseIterable, Sendable {
        case primary
        case secondary
        case tertiary
        case text
    }

    public enum Button: String, CaseIterable, Sendable {
        case primary
        case secondary
        case lightYellow = "light-yellow"
        case lightOrchid = "light-orchid"
        case lightBlue = "light-blue"
        case iconTransparent = "icon-transparent"
    }

    public enum CardBackground: String, CaseIterable, Sendable {
        case primary
        case secondary
    }

    public enum CV: String, CaseIterable, Sendable {
        case bgBodyScan = "bg-body-scan"
        case bgFitnessTest = "bg-fitness-test"
        case bgFlexibilityTest = "bg-flexibility-test"
        case primary
    }

    public enum Fg: String, CaseIterable, Sendable {
        case primary
        case secondary
        case primaryDark = "primary-dark"
        case primaryInv = "primary-inv"
        case primaryLight = "primary-light"
        case red
    }

    public enum Heading: String, CaseIterable, Sendable {
        case primary
        case primaryInv = "primary-inv"
    }

    public enum Overlay: String, CaseIterable, Sendable {
        case blackDark = "black-dark"
        case blackMedium = "black-medium"
        case cadetMedium = "cadet-medium"
    }

    public enum OverlayCard: String, CaseIterable, Sendable {
        case accent
        case `default`
    }

    public enum TextBody: String, CaseIterable, Sendable {
        case lightPrimary = "light-primary"
        case lightSecondary = "light-secondary"
        case bluePrimary = "blue-primary"
        case blueSecondary = "blue-secondary"
        case yellowPrimary = "yellow-primary"
        case orchidPrimary = "orchid-primary"
    }

    public init?(token: String) {
        guard let match = Self.allCases.first(where: { $0.token == token }) else {
            return nil
        }
        self = match
    }

    public static var allCases: [ColorToken] {
        Bg.allCases.map { .bg($0) } +
        Border.allCases.map { .border($0) } +
        Brand.allCases.map { .brand($0) } +
        Button.allCases.map { .button($0) } +
        CardBackground.allCases.map { .cardBackground($0) } +
        CV.allCases.map { .cv($0) } +
        Fg.allCases.map { .fg($0) } +
        Heading.allCases.map { .heading($0) } +
        Overlay.allCases.map { .overlay($0) } +
        OverlayCard.allCases.map { .overlayCard($0) } +
        TextBody.allCases.map { .textBody($0) }
    }

    public var token: String {
        switch self {
        case .bg(let token): "bg/\(token.rawValue)"
        case .border(let token): "border/\(token.rawValue)"
        case .brand(let token): "brand/\(token.rawValue)"
        case .button(let token): "button/bg-\(token.rawValue)"
        case .cardBackground(let token): "card-bg/\(token.rawValue)"
        case .cv(let token): "cv/\(token.rawValue)"
        case .fg(let token): "fg/\(token.rawValue)"
        case .heading(let token): "heading/\(token.rawValue)"
        case .overlay(let token): "overlay/\(token.rawValue)"
        case .overlayCard(let token): "overlay/card/\(token.rawValue)"
        case .textBody(let token): "text/body/\(token.rawValue)"
        }
    }
}
