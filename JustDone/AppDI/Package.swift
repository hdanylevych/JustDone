// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "AppDI",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppDI",
            targets: ["AppDI"]),
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../Persistence"),
        .package(url: "https://github.com/hmlongco/Factory", from: "2.5.3")
    ],
    targets: [
        .target(
            name: "AppDI",
            dependencies: [
                "Core", "Persistence",
                .product(name: "FactoryKit", package: "Factory")
            ]
        ),
    ]
)
