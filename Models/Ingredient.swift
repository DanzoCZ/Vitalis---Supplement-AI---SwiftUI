import Foundation

struct Ingredient: Identifiable, Hashable {
    let id: UUID
    let name: String
    let description: String
    let benefits: [String]
    let commonDosage: String
}
