// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Loop8AuthSDK",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Loop8AuthSDK",
            targets: ["Loop8AuthSDK"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "Loop8AuthSDK",
            url: "https://github.com/l8p8/loop8-auth-ios/releases/download/0.1.0/Loop8AuthSDK.xcframework.zip",
            checksum: "a41578084dd805e0a094efd1370d04046085718cddc785a50b4e9a214673d40f"
        )
    ]
)
