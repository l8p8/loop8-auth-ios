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
            checksum: "1ac111d9b52896d29f1ea2b05be4115af25b8e529dd2c4171547e81e3b2ef9ee"
        )
    ]
)
