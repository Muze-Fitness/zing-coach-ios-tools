/// Map design tokens to platform values by supplying a resolution closure.
///
/// Pass the resulting provider into ``Theme`` to define the value for every token.
///
/// ```swift
/// let colors = TokenProvider<ColorToken, UIColor> { token in
///     switch token {
///     case .brand(.primary):
///         UIColor(hex: 0x004070)
///     case .brand(.secondary):
///         UIColor(hex: 0x004F91)
///     ...
///     }
/// }
/// ```
public struct TokenProvider<Token, Value: Sendable>: Sendable {
    private let resolve: @Sendable (Token) -> Value

    /// Create a provider with a closure that resolves each token to a platform value.
    ///
    /// - Parameter resolve: Receives a token and returns the corresponding value.
    public init(_ resolve: @escaping @Sendable (Token) -> Value) {
        self.resolve = resolve
    }

    /// Look up the platform value for a token.
    ///
    /// - Parameter token: The design token to resolve.
    /// - Returns: The value from the resolution closure.
    public func value(from token: Token) -> Value {
        resolve(token)
    }
}
