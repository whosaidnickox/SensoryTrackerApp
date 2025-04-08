// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SensoryTrackerApp",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SensoryTrackerApp",
            targets: ["SensoryTrackerApp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mchoe/SwiftSVG.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "SensoryTrackerApp",
            dependencies: ["SwiftSVG"]),
        .testTarget(
            name: "SensoryTrackerAppTests",
            dependencies: ["SensoryTrackerApp"]),
    ]
) 