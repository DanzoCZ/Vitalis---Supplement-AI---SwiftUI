import SwiftUI

struct DesignSystem {
    // Colors
    static let primary = Color(red: 0.2, green: 0.8, blue: 0.5) // Emerald Green Approximation
    static let secondary = Color(red: 0.1, green: 0.4, blue: 0.8) // Blue Accent
    static let background = Color(UIColor.systemBackground)
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
    
    static let darkSurface = Color(white: 0.15)
    
    // Gradients
    static let primaryGradient = LinearGradient(
        colors: [primary, Color(red: 0.1, green: 0.6, blue: 0.4)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // For standard glass
    static let glassGradient = LinearGradient(
        colors: [Color.white.opacity(0.15), Color.white.opacity(0.05)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

extension View {
    func vTitleStyle() -> some View {
        self.font(.system(.title, design: .rounded).weight(.bold))
    }
    
    func vHeadlineStyle() -> some View {
        self.font(.system(.headline, design: .rounded).weight(.semibold))
    }
    
    func vBodyStyle() -> some View {
        self.font(.system(.body, design: .rounded))
    }
}
