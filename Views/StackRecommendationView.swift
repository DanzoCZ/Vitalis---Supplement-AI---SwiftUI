import SwiftUI

struct StackRecommendationView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedGoal: Effect = .focus
    @State private var budget: Double = 50.0
    @State private var isGenerating = false
    @State private var generatedStack: [Supplement] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    if generatedStack.isEmpty {
                        generatorForm
                    } else {
                        resultsView
                    }
                }
                .padding()
            }
            .navigationTitle(generatedStack.isEmpty ? "Build Stack" : "Your Stack")
            .navigationBarItems(trailing: Button("Close") { dismiss() })
            .animation(.default, value: generatedStack.isEmpty)
        }
    }
    
    private var generatorForm: View {
        VStack(alignment: .leading, spacing: 24) {
            // Goal selection
            VStack(alignment: .leading, spacing: 12) {
                Text("Primary Goal")
                    .vHeadlineStyle()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 12) {
                    ForEach(Effect.allCases) { effect in
                        GoalPill(effect: effect, isSelected: selectedGoal == effect) {
                            selectedGoal = effect
                        }
                    }
                }
            }
            
            // Budget Slider
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Monthly Budget")
                        .vHeadlineStyle()
                    Spacer()
                    Text(String(format: "$%.0f", budget))
                        .font(.headline)
                        .foregroundColor(DesignSystem.primary)
                }
                
                Slider(value: $budget, in: 20...150, step: 5)
                    .tint(DesignSystem.primary)
                
                HStack {
                    Text("$20")
                        .font(.caption)
                    Spacer()
                    Text("$150+")
                        .font(.caption)
                }
                .foregroundColor(.secondary)
            }
            
            Spacer(minLength: 40)
            
            Button(action: generateStack) {
                HStack {
                    if isGenerating {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Generate AI Stack")
                            .vHeadlineStyle()
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(DesignSystem.primaryGradient)
                .cornerRadius(16)
            }
            .disabled(isGenerating)
        }
    }
    
    private var resultsView: View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Perfect Match!")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(DesignSystem.primary)
                
                Text("Based on your goal of \(selectedGoal.rawValue) and budget of $\(Int(budget)), we recommend this daily protocol:")
                    .vBodyStyle()
                    .foregroundColor(.secondary)
            }
            
            let totalCost = generatedStack.reduce(0) { $0 + $1.price }
            
            VStack(spacing: 16) {
                ForEach(generatedStack) { supplement in
                    SupplementCardView(supplement: supplement)
                }
            }
            
            Divider()
            
            HStack {
                Text("Estimated Monthly Cost")
                    .vHeadlineStyle()
                Spacer()
                Text(String(format: "$%.2f", totalCost))
                    .font(.title3.weight(.bold))
                    .foregroundColor(totalCost <= budget ? DesignSystem.primary : .red)
            }
            
            Button("Save Protocol") { dismiss() }
                .buttonStyle(.borderedProminent)
                .tint(DesignSystem.primary)
                .frame(maxWidth: .infinity)
                .padding(.top, 16)
        }
    }
    
    private func generateStack() {
        isGenerating = true
        
        Task {
            try await Task.sleep(nanoseconds: 1_500_000_000)
            
            // Mock generation logic
            let pool = MockDataService.shared.supplements.filter { $0.effects.contains(selectedGoal) }
            
            var stack: [Supplement] = []
            var currentCost = 0.0
            
            for supp in pool.sorted(by: { $0.overallScore > $1.overallScore }) {
                if currentCost + supp.price <= budget {
                    stack.append(supp)
                    currentCost += supp.price
                }
            }
            
            // If empty, just give them the best one
            if stack.isEmpty, let best = pool.first {
                stack.append(best)
            }
            
            await MainActor.run {
                self.generatedStack = stack
                self.isGenerating = false
            }
        }
    }
}

#Preview {
    StackRecommendationView()
}
