import UIKit

/// Define the SDK's design tokens by supplying a token provider for every category.
///
/// Every token must resolve to an explicit value — there is no built-in fallback.
///
/// ```swift
/// let theme = Theme(
///     colors: TokenProvider { token in
///         switch token {
///         case .brand(.primary):
///             UIColor(hex: 0x004070)
///         case .brand(.secondary):
///             UIColor(hex: 0x004F91)
///         ...
///         }
///     },
///     assets: TokenProvider { token in
///         switch token {
///         case .planBackground:
///             UIImage.planBackground
///         ...
///         }
///     }
/// )
/// ```
public struct Theme: Sendable {
    /// Color provider.
    public let colors: TokenProvider<ColorToken, UIColor>
    /// Spacing provider.
    public let spacings: TokenProvider<SizeToken, CGFloat>
    /// Corner rounding provider.
    public let cornersRounding: TokenProvider<RadiusToken, RadiusAttribute>
    /// Typography provider.
    public let typography: TokenProvider<TypographyToken, TypographyAttributes>
    /// Asset provider.
    public let assets: TokenProvider<AssetToken, UIImage>
    /// Blur style provider.
    public let blurStyle: TokenProvider<BlurToken, UIBlurEffect.Style>

    /// Create a theme with a provider for each token category.
    ///
    /// - Parameters:
    ///   - colors: Resolves ``ColorToken`` to `UIColor`.
    ///   - spacings: Resolves ``SizeToken`` to `CGFloat`.
    ///   - cornersRounding: Resolves ``RadiusToken`` to `CGFloat`.
    ///   - typography: Resolves ``TypographyToken`` to ``TypographyAttributes``.
    ///   - assets: Resolves ``AssetToken`` to `UIImage`.
    ///   - blurStyle: Resolves ``BlurToken`` to `UIBlurEffect.Style`.
    public init(
        colors: TokenProvider<ColorToken, UIColor>,
        spacings: TokenProvider<SizeToken, CGFloat>,
        cornersRounding: TokenProvider<RadiusToken, RadiusAttribute>,
        typography: TokenProvider<TypographyToken, TypographyAttributes>,
        assets: TokenProvider<AssetToken, UIImage>,
        blurStyle: TokenProvider<BlurToken, UIBlurEffect.Style>
    ) {
        self.colors = colors
        self.spacings = spacings
        self.cornersRounding = cornersRounding
        self.typography = typography
        self.assets = assets
        self.blurStyle = blurStyle
    }
}

public typealias Transform<T, V> = (T, V) -> V

public extension TokenProvider {
    func byApplying(_ transform: @escaping Transform<Token, Value>) -> Self {
        TokenProvider { token in
            transform(token, self.value(from: token))
        }
    }
}

public extension Theme {
    func byApplying(
        colorsTransform: Transform<ColorToken, UIColor>? = nil,
        spacingsTransform: Transform<SizeToken, CGFloat>? = nil,
        cornersRoundingTransform: Transform<RadiusToken, RadiusAttribute>? = nil,
        typographyTransform: Transform<TypographyToken, TypographyAttributes>? = nil,
        assetsTransform: Transform<AssetToken, UIImage>? = nil,
        blurStyleTransform: Transform<BlurToken, UIBlurEffect.Style>? = nil
    ) -> Self {
        Theme(
            colors: colorsTransform.flatMap(colors.byApplying) ?? colors,
            spacings: spacingsTransform.flatMap(spacings.byApplying) ?? spacings,
            cornersRounding: cornersRoundingTransform.flatMap(cornersRounding.byApplying) ?? cornersRounding,
            typography: typographyTransform.flatMap(typography.byApplying) ?? typography,
            assets: assetsTransform.flatMap(assets.byApplying) ?? assets,
            blurStyle: blurStyleTransform.flatMap(blurStyle.byApplying) ?? blurStyle
        )
    }
}
