import CoreGraphics
import Foundation
internal import Lottie

/// Adapter wrapping Lottie's `LottieAnimation` model.
///
/// Use this type from public SDK code instead of importing Lottie directly.
public final class LottieAnimation: Sendable {

    // MARK: Lifecycle

    init(animation: Lottie.LottieAnimation) {
        self.animation = animation
    }

    // MARK: Public

    /// Loads an animation model from a bundle by its name. Returns `nil` if not found.
    public static func named(
        _ name: String,
        bundle: Bundle = .main,
        subdirectory: String? = nil
    ) -> LottieAnimation? {
        guard let animation = Lottie.LottieAnimation.named(name, bundle: bundle, subdirectory: subdirectory) else {
            return nil
        }
        return LottieAnimation(animation: animation)
    }

    /// Loads an animation from an absolute filepath.
    public static func filepath(_ filepath: String) -> LottieAnimation? {
        guard let animation = Lottie.LottieAnimation.filepath(filepath) else {
            return nil
        }
        return LottieAnimation(animation: animation)
    }

    /// Loads an animation model from the asset catalog by its name. Returns `nil` if not found.
    public static func asset(
        _ name: String,
        bundle: Bundle = .main
    ) -> LottieAnimation? {
        guard let animation = Lottie.LottieAnimation.asset(name, bundle: bundle) else {
            return nil
        }
        return LottieAnimation(animation: animation)
    }

    /// Loads a Lottie animation from JSON `Data`.
    public static func from(data: Data) throws -> LottieAnimation {
        let animation = try Lottie.LottieAnimation.from(data: data)
        return LottieAnimation(animation: animation)
    }

    /// Loads a Lottie animation asynchronously from a URL.
    public static func loadedFrom(
        url: URL,
        session: URLSession = .shared
    ) async -> LottieAnimation? {
        guard let animation = await Lottie.LottieAnimation.loadedFrom(url: url, session: session) else {
            return nil
        }
        return LottieAnimation(animation: animation)
    }

    /// Loads a Lottie animation asynchronously from a URL.
    public static func loadedFrom(
        url: URL,
        session: URLSession = .shared,
        closure: @escaping (LottieAnimation?) -> Void
    ) {
        Lottie.LottieAnimation.loadedFrom(url: url, session: session) { animation in
            closure(animation.map(LottieAnimation.init(animation:)))
        }
    }

    /// The start time of the composition in frame time.
    public var startFrame: AnimationFrameTime {
        animation.startFrame
    }

    /// The end time of the composition in frame time.
    public var endFrame: AnimationFrameTime {
        animation.endFrame
    }

    /// The frame rate of the composition.
    public var framerate: Double {
        animation.framerate
    }

    /// The duration in seconds of the animation.
    public var duration: TimeInterval {
        animation.duration
    }

    /// The natural bounds in points of the animation.
    public var bounds: CGRect {
        animation.bounds
    }

    /// The natural size in points of the animation.
    public var size: CGSize {
        animation.size
    }

    /// All marker names, in order, or an empty list if none are specified.
    public var markerNames: [String] {
        animation.markerNames
    }

    /// Returns the progress time for the named marker, or `nil` if not found.
    public func progressTime(forMarker named: String) -> AnimationProgressTime? {
        animation.progressTime(forMarker: named)
    }

    /// Returns the frame time for the named marker, or `nil` if not found.
    public func frameTime(forMarker named: String) -> AnimationFrameTime? {
        animation.frameTime(forMarker: named)
    }

    /// Returns the duration frame time for the named marker, or `nil` if not found.
    public func durationFrameTime(forMarker named: String) -> AnimationFrameTime? {
        animation.durationFrameTime(forMarker: named)
    }

    /// Converts frame time into progress time (optionally clamped to 0...1).
    public func progressTime(
        forFrame frameTime: AnimationFrameTime,
        clamped: Bool = true
    ) -> AnimationProgressTime {
        animation.progressTime(forFrame: frameTime, clamped: clamped)
    }

    /// Converts progress time (0...1) into frame time.
    public func frameTime(forProgress progressTime: AnimationProgressTime) -> AnimationFrameTime {
        animation.frameTime(forProgress: progressTime)
    }

    /// Converts frame time into seconds.
    public func time(forFrame frameTime: AnimationFrameTime) -> TimeInterval {
        animation.time(forFrame: frameTime)
    }

    /// Converts seconds into frame time.
    public func frameTime(forTime time: TimeInterval) -> AnimationFrameTime {
        animation.frameTime(forTime: time)
    }

    // MARK: Internal

    let animation: Lottie.LottieAnimation
}
