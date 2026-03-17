import SwiftUI

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            // Icon
            ZStack {
                Circle()
                    .fill(DesignSystem.primaryGradient)
                    .frame(width: 120, height: 120)
                
                Image(systemName: "leaf.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
            }
            .shadow(color: DesignSystem.primary.opacity(0.3), radius: 20, x: 0, y: 10)
            
            // Text
            VStack(spacing: 16) {
                Text("Welcome to Vitalis")
                    .vTitleStyle()
                
                Text("Analyze, compare, and personalize your supplement stack with AI-driven insights.")
                    .vBodyStyle()
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
            
            // Button
            Button(action: {
                withAnimation {
                    hasSeenOnboarding = true
                }
            }) {
                Text("Get Started")
                    .vHeadlineStyle()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(DesignSystem.primaryGradient)
                    .cornerRadius(16)
                    .shadow(color: DesignSystem.primary.opacity(0.3), radius: 10, y: 5)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(DesignSystem.background.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    OnboardingView(hasSeenOnboarding: .constant(false))
}
