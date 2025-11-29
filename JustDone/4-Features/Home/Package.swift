// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    dependencies: [
        .package(path: "../1-Domain/Core"),
        .package(path: "../1-Domain/DesignSystem"),
        .package(path: "../3-Composition/InfrastructureDI"),
        .package(url: "https://github.com/hmlongco/Factory", from: "2.5.3")
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                "Core", "DesignSystem", "InfrastructureDI",
                .product(name: "FactoryKit", package: "Factory")
            ]
        ),
    ]
)
