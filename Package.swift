// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PWAnalytics",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "PWAnalytics",
            targets: ["PWAnalytics"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "PWAnalytics",
            dependencies: [
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "PWAnalyticsTests",
            dependencies: ["PWAnalytics"]
        )
    ]
)
