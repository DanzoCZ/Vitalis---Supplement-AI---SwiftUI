import Foundation

enum Effect: String, CaseIterable, Identifiable {
    case focus = "Focus"
    case sleep = "Sleep"
    case energy = "Energy"
    case stress = "Stress Relief"
    case immunity = "Immunity"
    case muscleRecovery = "Muscle Recovery"
    case cognitivePerformance = "Cognitive Performance"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .focus, .cognitivePerformance: return "brain.head.profile"
        case .sleep: return "moon.stars.fill"
        case .energy: return "bolt.fill"
        case .stress: return "leaf.fill"
        case .immunity: return "shield.fill"
        case .muscleRecovery: return "figure.run"
        }
    }
}
