// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "QuickToolKit",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "QuickToolKit",
            targets: ["QuickToolKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "QuickToolKit",
            dependencies: []
        ),
    ]
)
