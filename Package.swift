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
            checksum: "256d07fa88412bbff22988180fd4975b433cc58eb7939559494f1802719664ec"
        )
    ]
)
