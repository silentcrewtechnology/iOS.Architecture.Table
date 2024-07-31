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
        .package(url: "https://gitlab.akbars.tech/abo/ios.architecture", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://gitlab.akbars.tech/abo/ios.designsystem", .upToNextMajor(from: "11.0.0")),
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
