// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Vitalis",
    platforms: [
        .iOS(.v17) // Nastav verzi iOS, pro kterou vyvíjíš
    ],
    products: [
        .library(
            name: "Vitalis",
            targets: ["Vitalis"]),
    ],
    targets: [
        .target(
            name: "Vitalis",
            path: ".", // Říká Swiftu, že soubory jsou v hlavní složce
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
