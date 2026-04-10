public enum AssetToken: Sendable {
    case planBackground
    case welcomePicture
    case coachImages(CoachAsset)

    public enum CoachAsset: Sendable {
        case john
        case jennifer
        case sarah
        case chris
        case manel
        case adriana
    }
}
