/// Map design tokens to platform values by supplying a resolution closure.
///
/// Pass the resulting provider into ``Theme`` to override default token values.
/// Return `nil` from the closure for tokens you do not need to customize --
/// the SDK falls back to its built-in defaults for those tokens.
///
/// ```swift
/// let colors = TokenProvider<ColorToken, UIColor> { token in
///     switch token {
///     case .brand(.primary):
///         UIColor(hex: 0x004070)
///     default:
///         nil
///     }
/// }
/// ```
public struct TokenProvider<Token, Value: Sendable>: Sendable {
    private let resolve: @Sendable (Token) -> Value?

    /// Create a provider with a closure that resolves each token to a platform value.
    ///
    /// Return `nil` for any token that should keep its default value.
    ///
    /// - Parameter resolve: Receives a token and returns the corresponding value, or `nil`.
    public init(_ resolve: @escaping @Sendable (Token) -> Value?) {
        self.resolve = resolve
    }

    /// Look up the platform value for a token.
    ///
    /// - Parameter token: The design token to resolve.
    /// - Returns: The value from the resolution closure, or `nil` when no override was provided.
    public func value(from token: Token) -> Value? {
        resolve(token)
    }
}
