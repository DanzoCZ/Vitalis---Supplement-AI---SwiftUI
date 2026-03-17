import Foundation

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isUser: Bool
    let timestamp = Date()
}

class AIAssistantService {
    static let shared = AIAssistantService()
    
    // Simulate AI thinking and responding
    func getResponse(for prompt: String) async throws -> String {
        try await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds delay
        
        let lowercasedPrompt = prompt.lowercased()
        
        if lowercasedPrompt.contains("focus") {
            return "For focus, I highly recommend looking into Lion's Mane mushroom extract and L-Theanine. Lion's Mane supports Nerve Growth Factor (NGF) production, while L-Theanine promotes a state of calm, alert focus. 'Flow Focus' and 'Lion's Mane Dual Extract' by SuperionHerbs are great options."
        } else if lowercasedPrompt.contains("lion's mane") || lowercasedPrompt.contains("lions mane") {
            return "Lion's Mane is an excellent adaptogenic mushroom. When choosing one, look for a dual extract that specifies the percentage of active compounds like Polysaccharides or Hericenones. SuperionHerbs makes a very high-quality powder, while Flow offers a great capsule form mixed with other nootropics."
        } else if lowercasedPrompt.contains("dosage") || lowercasedPrompt.contains("effective") {
            return "Dosage effectiveness depends heavily on the specific ingredient and extract ratio. For standard Ashwagandha (KSM-66), 300-600mg daily is clinically effective for stress reduction. What specific supplement's dosage are you wondering about?"
        } else if lowercasedPrompt.contains("sleep") {
            return "For deep, restorative sleep without grogginess, a combination of Magnesium Bisglycinate (200-400mg) and L-Theanine (100-200mg) works wonders. BrainMarket's 'Sleep Deeper' is fully formulated for this."
        } else if lowercasedPrompt.contains("recommend") || lowercasedPrompt.contains("stack") {
            return "I can generate a personalized stack for you! Let me know your main goal (e.g., focus, sleep, stress), budget, and whether you prefer capsules or powders."
        }
        
        return "That's an interesting question about supplements. Could you provide a bit more detail? For example, are you asking about a specific ingredient like Ashwagandha, or looking for something to help with a specific goal like sleep or energy?"
    }
}
