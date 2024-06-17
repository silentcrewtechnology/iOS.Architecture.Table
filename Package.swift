// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "ArchitectureTableView",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ArchitectureTableView",
            targets: ["ArchitectureTableView"]),
    ],
    dependencies: [
        .package(url: "https://gitlab.akbars.tech/abo/ios.architecture", .upToNextMinor(from: "0.0.6")),
        .package(url: "https://gitlab.akbars.tech/abo/ios.designsystem", .upToNextMinor(from: "4.0.3")),
    ],
    targets: [
        .target(
            name: "ArchitectureTableView",
            dependencies: [
                .product(name: "Architecture", package: "ios.architecture"),
                .product(name: "DesignSystem", package: "ios.designsystem"),
            ]
        ),
    ]
)
