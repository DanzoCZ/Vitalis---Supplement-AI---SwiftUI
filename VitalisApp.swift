import SwiftUI

@main
struct VitalisApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark) // Default to dark mode for premium feel, though components support both
        }
    }
}
