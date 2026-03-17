import Foundation

struct Brand: Identifiable, Hashable {
    let id: UUID
    let name: String
    let description: String
    let logoName: String // System image or asset name
    let transparencyScore: Double // 0-10
}
