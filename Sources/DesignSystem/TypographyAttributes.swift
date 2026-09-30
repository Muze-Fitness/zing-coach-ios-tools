import CoreGraphics

public struct TypographyAttributes: Sendable {
    public var fontFamily: String
    public var fontSize: CGFloat?
    public var lineHeightMultiple: CGFloat?
    public var letterSpacing: CGFloat?
    public var isMonospacedDigits: Bool?

    public init(
        fontFamily: String,
        fontSize: CGFloat? = nil,
        lineHeightMultiple: CGFloat? = nil,
        letterSpacing: CGFloat? = nil,
        isMonospacedDigits: Bool? = nil
    ) {
        self.fontFamily = fontFamily
        self.fontSize = fontSize
        self.lineHeightMultiple = lineHeightMultiple
        self.letterSpacing = letterSpacing
        self.isMonospacedDigits = isMonospacedDigits
    }
}
