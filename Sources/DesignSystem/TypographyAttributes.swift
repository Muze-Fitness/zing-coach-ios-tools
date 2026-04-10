import UIKit

public struct TypographyAttributes: Sendable {
    public var font: UIFont
    public var lineHeightMultiple: CGFloat
    public var letterSpacing: CGFloat
    public var isMonospacedDigits: Bool

    public init(
        font: UIFont,
        lineHeightMultiple: CGFloat,
        letterSpacing: CGFloat,
        isMonospacedDigits: Bool = false
    ) {
        self.font = font
        self.lineHeightMultiple = lineHeightMultiple
        self.letterSpacing = letterSpacing
        self.isMonospacedDigits = isMonospacedDigits
    }
}
