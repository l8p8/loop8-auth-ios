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
            url: "https://github.com/l8p8/loop8-auth-ios/releases/download/1.0.0/Loop8AuthSDK.xcframework.zip",
            checksum: "c3d715c4c4b95dcd14a8f11ba1652e870219d4e744701575d2daa365006403b0"
        )
    ]
)
