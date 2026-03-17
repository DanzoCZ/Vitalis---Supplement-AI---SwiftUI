// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Vitalis",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .executable(
            name: "Vitalis",
            targets: ["Vitalis"]),
    ],
    targets: [
        .executableTarget(
            name: "Vitalis",
            path: ".",
            sources: [
                "VitalisApp.swift",
                "Views",
                "ViewModels",
                "Models",
                "Services",
                "Components",
                "Utils"
            ]
        )
    ]
)
