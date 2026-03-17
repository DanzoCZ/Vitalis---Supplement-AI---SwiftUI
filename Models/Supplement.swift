import Foundation

struct Supplement: Identifiable, Hashable {
    let id: UUID
    let name: String
    let brand: Brand
    let type: SupplementType
    let ingredients: [SupplementIngredient]
    let effects: [Effect]
    
    let price: Double
    let servings: Int
    let imageUrl: String? // System image fallback if nil
    
    // Scores out of 10
    let ingredientQualityScore: Double
    let cleanLabelScore: Double // Based on lack of additives
    let valueScore: Double
    
    var overallScore: Double {
        return (ingredientQualityScore + cleanLabelScore + valueScore + brand.transparencyScore) / 4.0
    }
    
    var pricePerServing: Double {
        return price / Double(servings)
    }
    
    var hasAdditives: Bool {
        return cleanLabelScore < 8.0 // Simplified logic
    }
}

enum SupplementType: String, CaseIterable, Identifiable {
    case capsule = "Capsule"
    case powder = "Powder"
    case liquid = "Liquid"
    case tablet = "Tablet"
    case gummy = "Gummy"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .capsule: return "pills.fill"
        case .powder: return "allergens.fill"
        case .liquid: return "drop.fill"
        case .tablet: return "pills.circle.fill"
        case .gummy: return "star.fill" // Or some other representation
        }
    }
}

struct SupplementIngredient: Identifiable, Hashable {
    let id = UUID()
    let ingredient: Ingredient
    let dosage: Dosage
    let extractRatio: String? // E.g., "10:1"
}
