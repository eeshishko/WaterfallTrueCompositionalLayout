// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WaterfallTrueCompositionalLayout",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "WaterfallTrueCompositionalLayout",
            targets: ["WaterfallTrueCompositionalLayout"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "WaterfallTrueCompositionalLayout",
            dependencies: []),
        .testTarget(
            name: "WaterfallTrueCompositionalLayoutTests",
            dependencies: ["WaterfallTrueCompositionalLayout"]
        ),
    ]
)
