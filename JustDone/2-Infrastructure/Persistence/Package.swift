// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Persistence",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Persistence",
            targets: ["Persistence"]),
    ],
    dependencies: [
        .package(path: "../1-Domain/Core")
    ],
    targets: [
        .target(
            name: "Persistence",
            dependencies: [
                "Core"
            ],
            resources: [
                .process("Resources")
            ]
        ),
    ]
)
