import Foundation

class MockDataService {
    static let shared = MockDataService()
    
    // Brands
    let brainMarket = Brand(id: UUID(), name: "BrainMarket", description: "Premium supplements for body and mind.", logoName: "brain.head.profile", transparencyScore: 9.5)
    let gymBeam = Brand(id: UUID(), name: "GymBeam", description: "Fitness and sports nutrition.", logoName: "figure.run", transparencyScore: 8.0)
    let vilgain = Brand(id: UUID(), name: "Vilgain", description: "Clean label, high quality ingredients.", logoName: "leaf.fill", transparencyScore: 9.0)
    let flow = Brand(id: UUID(), name: "Flow", description: "Biohacking and cognitive performance.", logoName: "bolt.fill", transparencyScore: 9.2)
    let superionHerbs = Brand(id: UUID(), name: "SuperionHerbs", description: "High-quality mushroom extracts.", logoName: "tree.fill", transparencyScore: 9.8)
    
    // Ingredients
    let lionsMane = Ingredient(id: UUID(), name: "Lion's Mane", description: "Medicinal mushroom supporting cognitive function.", benefits: ["Focus", "Memory", "Nerve Growth"], commonDosage: "500-1000mg")
    let ashwagandha = Ingredient(id: UUID(), name: "Ashwagandha (KSM-66)", description: "Adaptogen that helps the body manage stress.", benefits: ["Stress Relief", "Sleep", "Testosterone"], commonDosage: "300-600mg")
    let magnesiumBisglycinate = Ingredient(id: UUID(), name: "Magnesium Bisglycinate", description: "Highly absorbable form of magnesium.", benefits: ["Sleep", "Muscle Recovery", "Relaxation"], commonDosage: "200-400mg")
    let lTheanine = Ingredient(id: UUID(), name: "L-Theanine", description: "Amino acid promoting relaxation without drowsiness.", benefits: ["Focus", "Calm", "Sleep"], commonDosage: "100-200mg")
    let omega3 = Ingredient(id: UUID(), name: "Omega-3 (EPA/DHA)", description: "Essential fatty acids.", benefits: ["Heart Health", "Brain Function", "Joints"], commonDosage: "1000-2000mg")
    
    var brands: [Brand] {
        [brainMarket, gymBeam, vilgain, flow, superionHerbs]
    }
    
    var ingredients: [Ingredient] {
        [lionsMane, ashwagandha, magnesiumBisglycinate, lTheanine, omega3]
    }
    
    var supplements: [Supplement] {
        [
            Supplement(
                id: UUID(),
                name: "Sleep Deeper",
                brand: brainMarket,
                type: .capsule,
                ingredients: [
                    SupplementIngredient(ingredient: magnesiumBisglycinate, dosage: Dosage(amount: 250, unit: "mg"), extractRatio: nil),
                    SupplementIngredient(ingredient: lTheanine, dosage: Dosage(amount: 200, unit: "mg"), extractRatio: nil)
                ],
                effects: [.sleep, .stress],
                price: 29.99,
                servings: 60,
                imageUrl: "pill.fill",
                ingredientQualityScore: 9.5,
                cleanLabelScore: 9.8,
                valueScore: 8.5
            ),
            Supplement(
                id: UUID(),
                name: "Flow Focus",
                brand: flow,
                type: .capsule,
                ingredients: [
                    SupplementIngredient(ingredient: lionsMane, dosage: Dosage(amount: 500, unit: "mg"), extractRatio: "10:1"),
                    SupplementIngredient(ingredient: lTheanine, dosage: Dosage(amount: 100, unit: "mg"), extractRatio: nil)
                ],
                effects: [.focus, .energy],
                price: 35.00,
                servings: 30,
                imageUrl: "brain.head.profile",
                ingredientQualityScore: 9.0,
                cleanLabelScore: 9.5,
                valueScore: 8.0
            ),
            Supplement(
                id: UUID(),
                name: "Ashwagandha KSM-66",
                brand: vilgain,
                type: .capsule,
                ingredients: [
                    SupplementIngredient(ingredient: ashwagandha, dosage: Dosage(amount: 500, unit: "mg"), extractRatio: "5% Withanolides")
                ],
                effects: [.stress, .sleep],
                price: 18.99,
                servings: 90,
                imageUrl: "leaf.fill",
                ingredientQualityScore: 9.2,
                cleanLabelScore: 10.0,
                valueScore: 9.5
            ),
            Supplement(
                id: UUID(),
                name: "Omega 3 Premium",
                brand: gymBeam,
                type: .capsule,
                ingredients: [
                    SupplementIngredient(ingredient: omega3, dosage: Dosage(amount: 1000, unit: "mg"), extractRatio: "330mg EPA / 220mg DHA")
                ],
                effects: [.cognitivePerformance, .muscleRecovery],
                price: 15.00,
                servings: 120,
                imageUrl: "drop.fill",
                ingredientQualityScore: 7.5,
                cleanLabelScore: 7.0,
                valueScore: 9.0
            ),
            Supplement(
                id: UUID(),
                name: "Lion's Mane Dual Extract",
                brand: superionHerbs,
                type: .powder,
                ingredients: [
                    SupplementIngredient(ingredient: lionsMane, dosage: Dosage(amount: 1000, unit: "mg"), extractRatio: "30% Polysaccharides")
                ],
                effects: [.focus, .immunity],
                price: 49.00,
                servings: 50,
                imageUrl: "tree.fill",
                ingredientQualityScore: 10.0,
                cleanLabelScore: 10.0,
                valueScore: 7.5
            )
        ]
    }
}
