// swift-tools-version:4.2
// Mason 2016-02-26

import PackageDescription

let package = Package(
    name: "Mason",

    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Mason",
            targets: ["Mason"]
        ),
        .executable(
            name: "m",
            targets: ["m"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target defines a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Mason",
            dependencies: []
        ),
        .target(
            name: "m",
            dependencies: ["Mason"]
        ),
        .testTarget(
            name: "MasonTests",
            dependencies: ["Mason"]
        ),
    ]
)
