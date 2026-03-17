import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showingStackRecommendation = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Goals Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("What's your goal today?")
                            .vHeadlineStyle()
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(Effect.allCases) { effect in
                                    GoalPill(effect: effect, isSelected: viewModel.selectedGoal == effect) {
                                        withAnimation {
                                            viewModel.selectGoal(viewModel.selectedGoal == effect ? nil : effect)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Stack Recommendation CTA
                    Button(action: { showingStackRecommendation = true }) {
                        HStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("AI Stack Generator")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Get personalized recommendations based on your goals and budget.")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                                    .multilineTextAlignment(.leading)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "sparkles")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(DesignSystem.primaryGradient)
                        .cornerRadius(20)
                        .shadow(color: DesignSystem.primary.opacity(0.3), radius: 10, y: 5)
                    }
                    .padding(.horizontal)
                    .sheet(isPresented: $showingStackRecommendation) {
                        StackRecommendationView() // To be implemented
                    }
                    
                    // Recommended Section based on Goal
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text(viewModel.selectedGoal != nil ? "Top Picks for \(viewModel.selectedGoal!.rawValue)" : "Trending Supplements")
                                .vHeadlineStyle()
                            Spacer()
                            Button("See All") { }
                                .font(.subheadline)
                                .foregroundColor(DesignSystem.primary)
                        }
                        .padding(.horizontal)
                        
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.recommendedStack) { supplement in
                                NavigationLink(value: supplement) {
                                    SupplementCardView(supplement: supplement)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Vitalis")
            .navigationDestination(for: Supplement.self) { supplement in
                SupplementDetailView(supplement: supplement)
            }
        }
    }
}

struct GoalPill: View {
    let effect: Effect
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: effect.iconName)
                Text(effect.rawValue)
            }
            .font(.subheadline.weight(.medium))
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(isSelected ? DesignSystem.primary : Color(UIColor.secondarySystemBackground))
            .foregroundColor(isSelected ? .white : .primary)
            .clipShape(Capsule())
            .shadow(color: isSelected ? DesignSystem.primary.opacity(0.3) : .clear, radius: 5, y: 2)
        }
    }
}

#Preview {
    HomeView()
}
