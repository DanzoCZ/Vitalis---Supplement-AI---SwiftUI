import Foundation

@MainActor
class AnalyzerViewModel: ObservableObject {
    @Published var inputIngredient: String = ""
    @Published var analysisResult: AnalysisResult? = nil
    @Published var isAnalyzing: Bool = false
    
    struct AnalysisResult {
        let effectivenessScore: Double
        let qualityScore: Double
        let safetyScore: Double
        let feedback: String
        let recommendedDosage: String
        
        var overallScore: Double {
            (effectivenessScore + qualityScore + safetyScore) / 3.0
        }
    }
    
    func analyze() {
        guard !inputIngredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        isAnalyzing = true
        analysisResult = nil
        
        // Mock analysis delay
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            
            let lowerInput = inputIngredient.lowercased()
            
            // Mock logic
            if lowerInput.contains("ashwagandha") {
                analysisResult = AnalysisResult(
                    effectivenessScore: 9.0,
                    qualityScore: 8.5,
                    safetyScore: 9.5,
                    feedback: "Ashwagandha is a highly effective adaptogen. Look for patented extracts like KSM-66 or Sensoril for guaranteed quality.",
                    recommendedDosage: "300-600mg daily"
                )
            } else if lowerInput.contains("magnesium") {
                analysisResult = AnalysisResult(
                    effectivenessScore: 9.5,
                    qualityScore: 9.0,
                    safetyScore: 10.0,
                    feedback: "Magnesium is essential. Avoid Oxide forms due to poor absorption. Bisglycinate is best for sleep, L-Threonate for brain health.",
                    recommendedDosage: "200-400mg daily"
                )
            } else {
                analysisResult = AnalysisResult(
                    effectivenessScore: 6.0,
                    qualityScore: 5.0,
                    safetyScore: 8.0,
                    feedback: "Information on this ingredient is limited or mixed. Ensure you source from a reputable brand and check for third-party testing.",
                    recommendedDosage: "Consult manufacturer label"
                )
            }
            
            isAnalyzing = false
            inputIngredient = ""
        }
    }
}
