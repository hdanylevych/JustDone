// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Utils",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Utils",
            targets: ["Utils"]),
    ],
    dependencies: [
        .package(path: "../1-Domain/Core")
    ],
    targets: [
        .target(
            name: "Utils",
            dependencies: [
                "Core"
            ]
        ),
    ]
)
