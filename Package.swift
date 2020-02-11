// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Worker",
    products: [
        .library(
            name: "Worker",
            targets: ["Worker"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Worker",
            dependencies: []),
        .testTarget(
            name: "WorkerTests",
            dependencies: ["Worker"]),
    ]
)
