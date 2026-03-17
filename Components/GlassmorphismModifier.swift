import SwiftUI

struct GlassmorphismModifier: ViewModifier {
    var cornerRadius: CGFloat
    var opacity: Double
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        let isDark = colorScheme == .dark
        let fillColor = isDark ? Color.black.opacity(opacity) : Color.white.opacity(opacity)
        let strokeStartColor = isDark ? Color.white.opacity(0.2) : Color.white.opacity(0.5)
        let strokeEndColor = isDark ? Color.white.opacity(0.05) : Color.white.opacity(0.1)
        
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(fillColor)
                    .background(
                        isDark ? .thinMaterial : .ultraThinMaterial,
                        in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    )
            )
            .shadow(color: Color.black.opacity(isDark ? 0.3 : 0.05), radius: 10, x: 0, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [strokeStartColor, .clear, strokeEndColor],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
    }
}

extension View {
    func glassmorphism(cornerRadius: CGFloat = 16, opacity: Double = 0.15) -> some View {
        self.modifier(GlassmorphismModifier(cornerRadius: cornerRadius, opacity: opacity))
    }
}
