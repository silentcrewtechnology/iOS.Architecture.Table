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
        .package(url: "https://github.com/silentcrewtechnology/iOS.Architecture.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/silentcrewtechnology/iOS.DesignSystem.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "ArchitectureTableView",
            dependencies: [
                .product(name: "Architecture", package: "iOS.Architecture"),
                .product(name: "DesignSystem", package: "iOS.DesignSystem"),
            ]
        ),
    ]
)
