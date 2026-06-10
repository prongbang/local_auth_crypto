// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "local_auth_crypto",
    platforms: [
        .iOS("11.0")
    ],
    products: [
        .library(name: "local-auth-crypto", targets: ["local_auth_crypto"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/prongbang/SecureBiometricSwift.git", .upToNextMinor(from: "0.0.2"))
    ],
    targets: [
        .target(
            name: "local_auth_crypto",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "SecureBiometricSwift", package: "SecureBiometricSwift")
            ]
        )
    ]
)
