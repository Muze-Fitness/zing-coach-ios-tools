import Foundation

public enum AssetToken: Sendable {
    case planBackground
    case welcomePicture
    case coachImages(CoachAsset)

    public enum CoachAsset: String, CaseIterable, Sendable {
        case john
        case jennifer
        case sarah
        case chris
        case manel
        case adriana
    }

    public init?(token: String) {
        guard let match = Self.allCases.first(where: { $0.token == token }) else {
            return nil
        }
        self = match
    }

    public static var allCases: [AssetToken] {
        [.planBackground, .welcomePicture] +
        CoachAsset.allCases.map { .coachImages($0) }
    }

    public var token: String {
        switch self {
        case .planBackground: "zing_plan_background"
        case .welcomePicture: "zing_welcome_picture"
        case .coachImages(let coach): "zing_coach_\(coach.rawValue)"
        }
    }
}
