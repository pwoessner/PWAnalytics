// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PWAnalytics",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PWAnalytics",
            targets: ["PWAnalytics"]),
    ],
    dependencies: [
        .package(url: "https://github.com/PostHog/posthog-ios", from: "2.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PWAnalytics",
            dependencies: [.product(name: "PostHog", package: "posthog-ios")]),
        .testTarget(
            name: "PWAnalyticsTests",
            dependencies: ["PWAnalytics"]),
    ]
)
