// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TD_Qvec_post_process",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "TD_Qvec_post_process",
            targets: ["TD_Qvec_post_process"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.1.0"),

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "TD_Qvec_post_process",
            dependencies: ["Utility"]),
        .testTarget(
            name: "TD_Qvec_post_processTests",
            dependencies: ["TD_Qvec_post_process","Utility"]),
    ]
)
