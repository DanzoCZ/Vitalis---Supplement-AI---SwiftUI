import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var selectedGoal: Effect? = nil
    @Published var featuredSupplements: [Supplement] = []
    @Published var recommendedStack: [Supplement] = []
    
    init() {
        fetchData()
    }
    
    private func fetchData() {
        // In a real app, this would be an async network call
        featuredSupplements = MockDataService.shared.supplements
        updateRecommendations()
    }
    
    func selectGoal(_ goal: Effect?) {
        selectedGoal = goal
        updateRecommendations()
    }
    
    private func updateRecommendations() {
        if let goal = selectedGoal {
            recommendedStack = MockDataService.shared.supplements.filter { $0.effects.contains(goal) }
        } else {
            recommendedStack = Array(MockDataService.shared.supplements.prefix(3))
        }
    }
}
