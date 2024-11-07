// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HitfaaViewModel",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HitfaaViewModel",
            targets: ["HitfaaViewModel"]),
    ],
    dependencies: [
        .package(path: "../HitfaaModel"),
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.15.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "HitfaaViewModel",
            dependencies: ["HitfaaModel",
                           .product(name: "SQLite",
                                    package: "SQLite.swift")]),
        .testTarget(
            name: "HitfaaViewModelTests",
            dependencies: ["HitfaaViewModel"]),
    ]
)
