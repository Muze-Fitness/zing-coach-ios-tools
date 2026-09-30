// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "ZingCoachTools",
    platforms: [.iOS(.v16), .watchOS(.v9)],
    products: [
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
        .library(name: "LottieAdapter", type: .dynamic, targets: ["LottieAdapter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-ios.git", .upToNextMajor(from: "4.5.0")),
    ],
    targets: [
        .target(name: "DesignSystem"),
        .target(
            name: "LottieAdapter",
            dependencies: [
                .product(name: "Lottie", package: "lottie-ios"),
            ]
        ),
    ]
)
