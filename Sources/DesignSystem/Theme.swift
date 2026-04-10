import UIKit

/// Override the SDK's default design tokens by supplying token providers for the categories you want to customize.
///
/// Pass `nil` for any provider (or omit it) to keep the SDK's built-in defaults for that category.
/// Only create providers for the token categories your brand needs to change.
///
/// ```swift
/// let theme = Theme(
///     colors: TokenProvider { token in
///         switch token {
///         case .brand(.primary):
///             UIColor(hex: 0x004070)
///         case .brand(.secondary):
///             UIColor(hex: 0x004F91)
///         default:
///             nil
///         }
///     },
///     assets: TokenProvider { token in
///         switch token {
///         case .planBackground:
///             UIImage.planBackground
///         default:
///             nil
///         }
///     }
/// )
/// ```
public struct Theme: Sendable {
    /// Color overrides. Pass `nil` to use default colors.
    public let colors: TokenProvider<ColorToken, UIColor>?
    /// Spacing overrides. Pass `nil` to use default spacings.
    public let spacings: TokenProvider<SizeToken, CGFloat>?
    /// Corner rounding overrides. Pass `nil` to use default radii.
    public let cornersRounding: TokenProvider<RadiusToken, CGFloat>?
    /// Typography overrides. Pass `nil` to use default typography.
    public let typography: TokenProvider<TypographyToken, TypographyAttributes>?
    /// Asset overrides. Pass `nil` to use default images.
    public let assets: TokenProvider<AssetToken, UIImage>?

    /// Create a theme with optional overrides for each token category.
    ///
    /// Omit any parameter (or pass `nil`) to keep the SDK's built-in defaults for that category.
    ///
    /// - Parameters:
    ///   - colors: Resolves ``ColorToken`` to `UIColor`.
    ///   - typography: Resolves ``TypographyToken`` to ``TypographyAttributes``.
    ///   - assets: Resolves ``AssetToken`` to `UIImage`.
    public init(
        colors: TokenProvider<ColorToken, UIColor>? = nil,
        typography: TokenProvider<TypographyToken, TypographyAttributes>? = nil,
        assets: TokenProvider<AssetToken, UIImage>? = nil
    ) {
        self.colors = colors
        self.spacings = nil
        self.cornersRounding = nil
        self.typography = typography
        self.assets = assets
    }
}
