// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "QuickTableKit",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "QuickTableKit",
            targets: ["QuickTableKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "QuickTableKit",
            dependencies: []
        ),
    ]
)
