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
            checksum: "49f4cc2e207ca81e335dd58f83c3bdf952ce4f27536d74d981860aa69189b805"
        )
    ]
)
