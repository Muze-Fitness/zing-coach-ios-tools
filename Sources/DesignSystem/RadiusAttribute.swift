import Foundation

public enum RadiusAttribute: Sendable {
    case value(CGFloat)
    case pill

    public init?(entry: [String: Any]) {
        guard let type = entry["type"] as? String else {
            return nil
        }
        switch type {
        case "value":
            guard let number = entry["value"] as? CGFloat else {
                return nil
            }
            self = .value(number)
        case "pill":
            self = .pill
        default:
            return nil
        }
    }
}
