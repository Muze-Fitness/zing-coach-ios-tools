internal import Lottie
import SwiftUI

/// Adapter wrapping Lottie's SwiftUI `LottieView`.
///
/// Use this type from public SDK code instead of importing Lottie directly.
/// Forwards the curated declarative playback API analogous to `LottieAnimationView`.
public struct LottieView<Placeholder: View>: View {

    // MARK: Lifecycle

    /// Creates a view that displays the given animation.
    public init(animation: LottieAnimation?) where Placeholder == EmptyView {
        lottieView = Lottie.LottieView(animation: animation?.animation)
    }

    /// Loads a Lottie animation from a JSON file in the supplied bundle.
    public init(
        name: String,
        bundle: Bundle = .main,
        subdirectory: String? = nil
    ) where Placeholder == EmptyView {
        self.init(animation: .named(name, bundle: bundle, subdirectory: subdirectory))
    }

    /// Loads a Lottie animation from a JSON file at a specific path on disk.
    public init(filePath: String) where Placeholder == EmptyView {
        self.init(animation: .filepath(filePath))
    }

    /// Loads a Lottie animation from a JSON file in the asset catalog of the supplied bundle.
    public init(
        asset name: String,
        bundle: Bundle = .main
    ) where Placeholder == EmptyView {
        self.init(animation: .asset(name, bundle: bundle))
    }

    /// Creates a view that asynchronously loads and displays an animation.
    /// The load closure is called once on appear.
    public init(
        _ loadAnimation: @escaping () async throws -> LottieAnimation?
    ) where Placeholder == EmptyView {
        lottieView = Lottie.LottieView {
            try await loadAnimation()?.animation
        }
    }

    /// Creates a view that asynchronously loads and displays an animation.
    /// While loading, the `placeholder` view is shown.
    public init(
        _ loadAnimation: @escaping () async throws -> LottieAnimation?,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        lottieView = Lottie.LottieView {
            try await loadAnimation()?.animation
        } placeholder: {
            placeholder()
        }
    }

    // MARK: Public

    public var body: some View {
        lottieView
    }

    /// Plays once from the current frame to the end frame.
    public func play() -> Self {
        map { $0.play() }
    }

    /// Plays from the current frame to the end frame with the given loop mode.
    public func play(loopMode: LottieAnimationView.LoopMode = .playOnce) -> Self {
        map { $0.play(loopMode: loopMode.lottieValue) }
    }

    /// Plays once from the current frame to the end frame.
    public func playing() -> Self {
        map { $0.playing() }
    }

    /// Plays from the current frame to the end frame with the given loop mode.
    public func playing(loopMode: LottieAnimationView.LoopMode) -> Self {
        map { $0.playing(loopMode: loopMode.lottieValue) }
    }

    /// Loops the animation from start to end whenever visible.
    public func looping() -> Self {
        map { $0.looping() }
    }

    /// Plays from a progress (0...1) to a progress (0...1).
    public func playing(
        fromProgress: AnimationProgressTime? = nil,
        toProgress: AnimationProgressTime,
        loopMode: LottieAnimationView.LoopMode = .playOnce
    ) -> Self {
        map {
            $0.playing(.fromProgress(fromProgress, toProgress: toProgress, loopMode: loopMode.lottieValue))
        }
    }

    /// Plays from a start frame to an end frame.
    public func playing(
        fromFrame: AnimationFrameTime? = nil,
        toFrame: AnimationFrameTime,
        loopMode: LottieAnimationView.LoopMode = .playOnce
    ) -> Self {
        map {
            $0.playing(.fromFrame(fromFrame, toFrame: toFrame, loopMode: loopMode.lottieValue))
        }
    }

    /// Plays from a named marker to another marker.
    public func playing(
        fromMarker: String? = nil,
        toMarker: String,
        playEndMarkerFrame: Bool = true,
        loopMode: LottieAnimationView.LoopMode = .playOnce
    ) -> Self {
        map {
            $0.playing(
                .fromMarker(
                    fromMarker,
                    toMarker: toMarker,
                    playEndMarkerFrame: playEndMarkerFrame,
                    loopMode: loopMode.lottieValue
                )
            )
        }
    }

    /// Plays from a named marker for the marker's duration.
    public func playing(
        marker: String,
        loopMode: LottieAnimationView.LoopMode = .playOnce
    ) -> Self {
        map { $0.playing(.marker(marker, loopMode: loopMode.lottieValue)) }
    }

    /// Plays the given markers sequentially in order.
    public func playing(markers: [String]) -> Self {
        map { $0.playing(.markers(markers)) }
    }

    /// Pauses the animation at the current frame.
    public func paused() -> Self {
        map { $0.paused() }
    }

    /// Sets the animation playback speed.
    public func animationSpeed(_ animationSpeed: Double) -> Self {
        map { $0.animationSpeed(animationSpeed) }
    }

    /// Sets the background behavior when the app moves to the background.
    public func backgroundBehavior(_ value: LottieAnimationView.BackgroundBehavior) -> Self {
        map { $0.backgroundBehavior(value.lottieValue) }
    }

    /// Sets a completion handler called when an animation finishes playing.
    public func animationDidFinish(
        _ animationCompletionHandler: LottieAnimationView.Completion?
    ) -> Self {
        map { $0.animationDidFinish(animationCompletionHandler) }
    }

    /// Displays the given progress and pauses any existing animation.
    public func currentProgress(_ currentProgress: AnimationProgressTime?) -> Self {
        map { $0.currentProgress(currentProgress) }
    }

    /// Displays the given frame and pauses any existing animation.
    public func currentFrame(_ currentFrame: AnimationFrameTime?) -> Self {
        map { $0.currentFrame(currentFrame) }
    }

    /// Displays the given time and pauses any existing animation.
    public func currentTime(_ currentTime: TimeInterval?) -> Self {
        map { $0.currentTime(currentTime) }
    }

    /// Scales the animation to always fit the size offered by its parent.
    public func resizable() -> Self {
        map { $0.resizable() }
    }

    /// Sets the content mode of the underlying animation view.
    public func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        map {
            $0.configure { view in
                view.contentMode = contentMode
            }
        }
    }

    /// Reloads the animation whenever the given value changes.
    /// Requires an async load initializer.
    public func reloadAnimationTrigger(_ value: some Equatable, showPlaceholder: Bool = true) -> Self {
        map { $0.reloadAnimationTrigger(value, showPlaceholder: showPlaceholder) }
    }

    // MARK: Private

    private var lottieView: Lottie.LottieView<Placeholder>

    private func map(
        _ transform: (Lottie.LottieView<Placeholder>) -> Lottie.LottieView<Placeholder>
    ) -> Self {
        var copy = self
        copy.lottieView = transform(lottieView)
        return copy
    }
}
