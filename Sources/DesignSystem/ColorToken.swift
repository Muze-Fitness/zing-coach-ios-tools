import Foundation

public enum ColorToken: Sendable {
    case brand(Brand)
    case textHeading(TextHeading)
    case textBody(TextBody)
    case overlay(Overlay)
    case buttonBackground(ButtonBackground)
    case background(Background)

    public enum Brand: String, CaseIterable, Sendable {
        /// Default: orchid500 (#8C25F4)
        case primary
        /// Default: blue600 (#1A4CE5)
        case secondary
        /// Default: grey800 (#1D212C)
        case tertiary
    }

    public enum TextHeading: String, CaseIterable, Sendable {
        /// Default: black100 (#000000)
        case darkPrimary = "dark-primary"
        /// Default: white100 (#FFFFFF)
        case lightPrimary = "light-primary"
    }

    public enum TextBody: String, CaseIterable, Sendable {
        /// Default: black100 (#000000)
        case darkPrimary = "dark-primary"
        /// Default: grey500 (#7985A7)
        case darkSecondary = "dark-secondary"
        /// Default: white100 (#FFFFFF)
        case lightPrimary = "light-primary"
        /// Default: grey300 (#CED2DF)
        case lightSecondary = "light-secondary"
        /// Default: blue800 (#041755)
        case bluePrimary = "blue-primary"
        /// Default: blue700 (#0E309A)
        case blueSecondary = "blue-secondary"
        /// Default: yellow800 (#281E03)
        case yellowPrimary = "yellow-primary"
        /// Default: orchid800 (#1B0237)
        case orchidPrimary = "orchid-primary"
    }

    public enum Overlay: String, CaseIterable, Sendable {
        /// Default: black64 (#000000, 64% opacity)
        case blackDark = "black-dark"
        /// Default: black40 (#000000, 40% opacity)
        case blackMedium = "black-medium"
        /// Default: spaceCadet800-40 (#100D29, 40% opacity)
        case cadetMedium = "cadet-medium"
    }

    public enum ButtonBackground: String, CaseIterable, Sendable {
        /// Default: black100 (#000000)
        case darkPrimary = "dark-primary"
        /// Default: grey800 (#1D212C)
        case darkSecondary = "dark-secondary"
        /// Default: white100 (#FFFFFF)
        case lightPrimary = "light-primary"
        /// Default: grey100 (#F4F6FA)
        case lightSecondary = "light-secondary"
        /// Default: yellow100 (#FFF4D0)
        case lightYellow = "light-yellow"
        /// Default: orchid100 (#F4EAFE)
        case lightOrchid = "light-orchid"
        /// Default: blue100 (#EEF4FE)
        case lightBlue = "light-blue"
        /// Default: white24 (#FFFFFF, 24% opacity)
        case iconTransparent = "icon-transparent"
    }

    public enum Background: String, CaseIterable, Sendable {
        /// Default: white100 (#FFFFFF)
        case white
        /// Default: grey100 (#F4F6FA)
        case lightGrey = "light-grey"
    }

    public init?(token: String) {
        guard let match = Self.allCases.first(where: { $0.token == token }) else {
            return nil
        }
        self = match
    }

    public static var allCases: [ColorToken] {
        Brand.allCases.map { .brand($0) } +
        TextHeading.allCases.map { .textHeading($0) } +
        TextBody.allCases.map { .textBody($0) } +
        Overlay.allCases.map { .overlay($0) } +
        ButtonBackground.allCases.map { .buttonBackground($0) } +
        Background.allCases.map { .background($0) }
    }

    public var token: String {
        switch self {
        case .brand(let token): "brand/\(token.rawValue)"
        case .textHeading(let token): "text/heading/\(token.rawValue)"
        case .textBody(let token): "text/body/\(token.rawValue)"
        case .overlay(let token): "overlay/\(token.rawValue)"
        case .buttonBackground(let token): "button/bg-\(token.rawValue)"
        case .background(let token): "bg/\(token.rawValue)"
        }
    }
}
