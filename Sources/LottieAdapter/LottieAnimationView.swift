internal import Lottie
import UIKit

/// Adapter wrapping Lottie's `LottieAnimationView`.
///
/// Use this type from public SDK code instead of importing Lottie directly.
/// Embeds a private Lottie view and forwards the curated playback API.
public final class LottieAnimationView: UIView {

    // MARK: Nested Types

    /// Defines animation loop behavior.
    public enum LoopMode: Hashable, Sendable {
        /// Animation is played once then stops.
        case playOnce
        /// Animation will loop from beginning to end until stopped.
        case loop
        /// Animation will play forward, then backwards and loop until stopped.
        case autoReverse
        /// Animation will loop from beginning to end up to a defined amount of times.
        case `repeat`(Float)
        /// Animation will play forward, then backwards a defined amount of times.
        case repeatBackwards(Float)
    }

    /// Describes the behavior of an animation view when the app moves to the background.
    public enum BackgroundBehavior: Sendable {
        /// Stop the animation and reset it to the beginning of its current play time.
        case stop
        /// Pause the animation in its current state.
        case pause
        /// Pause the animation and restart it when the application moves to the foreground.
        case pauseAndRestore
        /// Stops the animation and sets it to the end of its current play time.
        case forceFinish
        /// The animation continues playing in the background.
        case continuePlaying
    }

    /// Closure called when animation playback finishes. The `Bool` is `true` if the animation completed.
    public typealias Completion = (Bool) -> Void

    // MARK: Lifecycle

    public init(animation: LottieAnimation? = nil) {
        animationView = Lottie.LottieAnimationView(animation: animation?.animation)
        super.init(frame: animation?.bounds ?? .zero)
        commonInit()
    }

    public override init(frame: CGRect) {
        animationView = Lottie.LottieAnimationView(frame: frame)
        super.init(frame: frame)
        commonInit()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Loads a Lottie animation from a JSON file in the supplied bundle.
    public convenience init(
        name: String,
        bundle: Bundle = .main,
        subdirectory: String? = nil
    ) {
        self.init(animation: .named(name, bundle: bundle, subdirectory: subdirectory))
    }

    /// Loads a Lottie animation from a JSON file at a specific path on disk.
    public convenience init(filePath: String) {
        self.init(animation: .filepath(filePath))
    }

    /// Loads a Lottie animation from a JSON file in the asset catalog of the supplied bundle.
    public convenience init(
        asset name: String,
        bundle: Bundle = .main
    ) {
        self.init(animation: .asset(name, bundle: bundle))
    }

    // MARK: Public

    public override var contentMode: UIView.ContentMode {
        get { animationView.contentMode }
        set {
            super.contentMode = newValue
            animationView.contentMode = newValue
        }
    }

    /// Sets the animation backing the animation view.
    public var animation: LottieAnimation? {
        get {
            animationView.animation.map(LottieAnimation.init(animation:))
        }
        set {
            animationView.animation = newValue?.animation
        }
    }

    /// Sets the loop behavior for `play` calls. Defaults to `playOnce`.
    public var loopMode: LoopMode {
        get { LoopMode(animationView.loopMode) }
        set { animationView.loopMode = newValue.lottieValue }
    }

    /// Sets the speed of the animation playback. Defaults to 1.
    public var animationSpeed: CGFloat {
        get { animationView.animationSpeed }
        set { animationView.animationSpeed = newValue }
    }

    /// Sets the current animation time with a progress time.
    public var currentProgress: AnimationProgressTime {
        get { animationView.currentProgress }
        set { animationView.currentProgress = newValue }
    }

    /// Sets the current animation time in seconds.
    public var currentTime: TimeInterval {
        get { animationView.currentTime }
        set { animationView.currentTime = newValue }
    }

    /// Sets the current animation time with a frame in the animation's framerate.
    public var currentFrame: AnimationFrameTime {
        get { animationView.currentFrame }
        set { animationView.currentFrame = newValue }
    }

    /// Returns the current animation frame while an animation is playing.
    public var realtimeAnimationFrame: AnimationFrameTime {
        animationView.realtimeAnimationFrame
    }

    /// Returns the current animation progress while an animation is playing.
    public var realtimeAnimationProgress: AnimationProgressTime {
        animationView.realtimeAnimationProgress
    }

    /// Returns `true` if the animation is currently playing.
    public var isAnimationPlaying: Bool {
        animationView.isAnimationPlaying
    }

    /// Describes the behavior when the app moves to the background.
    public var backgroundBehavior: BackgroundBehavior {
        get { BackgroundBehavior(animationView.backgroundBehavior) }
        set { animationView.backgroundBehavior = newValue.lottieValue }
    }

    /// When `true`, the animation view rasterizes its contents when not animating.
    public var shouldRasterizeWhenIdle: Bool {
        get { animationView.shouldRasterizeWhenIdle }
        set { animationView.shouldRasterizeWhenIdle = newValue }
    }

    /// When `true`, the animation plays back at the framerate encoded in the animation model.
    public var respectAnimationFrameRate: Bool {
        get { animationView.respectAnimationFrameRate }
        set { animationView.respectAnimationFrameRate = newValue }
    }

    /// Whether or not the animation is masked to the bounds. Defaults to `true`.
    public var maskAnimationToBounds: Bool {
        get { animationView.maskAnimationToBounds }
        set { animationView.maskAnimationToBounds = newValue }
    }

    public override var intrinsicContentSize: CGSize {
        animationView.intrinsicContentSize
    }

    /// Plays the animation from its current state to the end.
    public func play(completion: Completion? = nil) {
        animationView.play(completion: completion)
    }

    /// Plays the animation from a progress (0...1) to a progress (0...1).
    public func play(
        fromProgress: AnimationProgressTime? = nil,
        toProgress: AnimationProgressTime,
        loopMode: LoopMode? = nil,
        completion: Completion? = nil
    ) {
        animationView.play(
            fromProgress: fromProgress,
            toProgress: toProgress,
            loopMode: loopMode?.lottieValue,
            completion: completion
        )
    }

    /// Plays the animation from a start frame to an end frame.
    public func play(
        fromFrame: AnimationFrameTime? = nil,
        toFrame: AnimationFrameTime,
        loopMode: LoopMode? = nil,
        completion: Completion? = nil
    ) {
        animationView.play(
            fromFrame: fromFrame,
            toFrame: toFrame,
            loopMode: loopMode?.lottieValue,
            completion: completion
        )
    }

    /// Plays the animation from a named marker to another marker.
    public func play(
        fromMarker: String? = nil,
        toMarker: String,
        playEndMarkerFrame: Bool = true,
        loopMode: LoopMode? = nil,
        completion: Completion? = nil
    ) {
        animationView.play(
            fromMarker: fromMarker,
            toMarker: toMarker,
            playEndMarkerFrame: playEndMarkerFrame,
            loopMode: loopMode?.lottieValue,
            completion: completion
        )
    }

    /// Plays the animation from a named marker for the marker's duration.
    public func play(
        marker: String,
        loopMode: LoopMode? = nil,
        completion: Completion? = nil
    ) {
        animationView.play(
            marker: marker,
            loopMode: loopMode?.lottieValue,
            completion: completion
        )
    }

    /// Plays the given markers sequentially in order.
    public func play(
        markers: [String],
        completion: Completion? = nil
    ) {
        animationView.play(markers: markers, completion: completion)
    }

    /// Stops the animation and resets the view to its start frame.
    public func stop() {
        animationView.stop()
    }

    /// Pauses the animation in its current state.
    public func pause() {
        animationView.pause()
    }

    // MARK: Private

    private let animationView: Lottie.LottieAnimationView

    private func commonInit() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: topAnchor),
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - LoopMode Mapping

extension LottieAnimationView.LoopMode {
    init(_ value: LottieLoopMode) {
        switch value {
        case .playOnce:
            self = .playOnce
        case .loop:
            self = .loop
        case .autoReverse:
            self = .autoReverse
        case .repeat(let count):
            self = .repeat(count)
        case .repeatBackwards(let count):
            self = .repeatBackwards(count)
        }
    }

    var lottieValue: LottieLoopMode {
        switch self {
        case .playOnce:
            .playOnce
        case .loop:
            .loop
        case .autoReverse:
            .autoReverse
        case .repeat(let count):
            .repeat(count)
        case .repeatBackwards(let count):
            .repeatBackwards(count)
        }
    }
}

// MARK: - BackgroundBehavior Mapping

extension LottieAnimationView.BackgroundBehavior {
    init(_ value: LottieBackgroundBehavior) {
        switch value {
        case .stop:
            self = .stop
        case .pause:
            self = .pause
        case .pauseAndRestore:
            self = .pauseAndRestore
        case .forceFinish:
            self = .forceFinish
        case .continuePlaying:
            self = .continuePlaying
        }
    }

    var lottieValue: LottieBackgroundBehavior {
        switch self {
        case .stop:
            .stop
        case .pause:
            .pause
        case .pauseAndRestore:
            .pauseAndRestore
        case .forceFinish:
            .forceFinish
        case .continuePlaying:
            .continuePlaying
        }
    }
}
