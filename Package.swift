// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

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
        .package(url: "https://gitlab.akbars.tech/abo/ios.designsystem", exact: "3.3.0"),
    ],
    targets: [
        .target(
            name: "ArchitectureTableView",
            dependencies: [
                .product(name: "Architecture", package: "ios.architecture"),
                .product(name: "DesignSystem", package: "ios.designsystem"),
            ]
        ),
        .testTarget(
            name: "ArchitectureTableViewTests",
            dependencies: ["ArchitectureTableView"]),
    ]
)
