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
    targets: [
        .target(name: "PWAnalytics"),
        .testTarget(
            name: "PWAnalyticsTests",
            dependencies: ["PWAnalytics"]
        )
    ]
)
