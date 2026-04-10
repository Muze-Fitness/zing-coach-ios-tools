// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "ZingCoachTools",
    platforms: [.iOS(.v16), .watchOS(.v9)],
    products: [
        .library(name: "DesignSystem", targets: ["DesignSystem"])
    ],
    targets: [
        .target(name: "DesignSystem")
    ]
)
