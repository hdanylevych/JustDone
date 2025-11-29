// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "InfrastructureDI",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "InfrastructureDI",
            targets: ["InfrastructureDI"]),
    ],
    dependencies: [
        .package(path: "../1-Domain/Core"),
        .package(path: "../2-Infrastructure/Persistence"),
        .package(path: "../2-Infrastructure/Utils"),
        .package(url: "https://github.com/hmlongco/Factory", from: "2.5.3")
    ],
    targets: [
        .target(
            name: "InfrastructureDI",
            dependencies: [
                "Core", "Persistence", "Utils",
                .product(name: "FactoryKit", package: "Factory")
            ]
        ),
    ]
)
