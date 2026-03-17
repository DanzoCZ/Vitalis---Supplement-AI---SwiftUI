import SwiftUI

struct AnalyzerView: View {
    @StateObject private var viewModel = AnalyzerViewModel()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header banner
                    VStack(spacing: 12) {
                        Image(systemName: "waveform.path.ecg")
                            .font(.system(size: 40))
                            .foregroundColor(DesignSystem.primary)
                        
                        Text("Supplement Scanner")
                            .vTitleStyle()
                        
                        Text("Enter an ingredient or full supplement name to analyze its effectiveness, safety, and proper dosage.")
                            .vBodyStyle()
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top)
                    
                    // Input Card
                    VStack(spacing: 16) {
                        TextField("E.g., Ashwagandha KSM-66, Magnesium...", text: $viewModel.inputIngredient)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                            .focused($isFocused)
                        
                        Button(action: {
                            isFocused = false
                            viewModel.analyze()
                        }) {
                            HStack {
                                if viewModel.isAnalyzing {
                                    ProgressView()
                                        .tint(.white)
                                } else {
                                    Text("Analyze")
                                        .vHeadlineStyle()
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(viewModel.inputIngredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? AnyView(Color.gray) : AnyView(DesignSystem.primaryGradient))
                            .cornerRadius(16)
                        }
                        .disabled(viewModel.inputIngredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isAnalyzing)
                    }
                    .padding()
                    .glassmorphism(cornerRadius: 20)
                    .padding(.horizontal)
                    
                    // Results Area
                    if let result = viewModel.analysisResult {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Analysis Complete")
                                .vHeadlineStyle()
                            
                            HStack(spacing: 16) {
                                ScoreBadgeView(score: result.overallScore, label: "Overall Score", showMaxScore: true)
                                Spacer()
                            }
                            
                            VStack(spacing: 12) {
                                AnalyzerBar(title: "Effectiveness", score: result.effectivenessScore)
                                AnalyzerBar(title: "Quality Standard", score: result.qualityScore)
                                AnalyzerBar(title: "Safety", score: result.safetyScore)
                            }
                            
                            Divider()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("AI Insights:")
                                    .font(.subheadline.weight(.bold))
                                Text(result.feedback)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Recommended Dosage:")
                                    .font(.subheadline.weight(.bold))
                                Text(result.recommendedDosage)
                                    .font(.subheadline)
                                    .foregroundColor(DesignSystem.primary)
                            }
                        }
                        .padding()
                        .glassmorphism(cornerRadius: 20, opacity: 0.15)
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    
                    Spacer(minLength: 40)
                }
            }
            .navigationTitle("Analyzer")
            .navigationBarHidden(true)
            .animation(.easeInOut, value: viewModel.analysisResult != nil)
        }
    }
}

struct AnalyzerBar: View {
    let title: String
    let score: Double // 0-10
    
    var color: Color {
        if score >= 9.0 { return DesignSystem.primary }
        if score >= 7.0 { return .orange }
        return .red
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.caption.weight(.medium))
                Spacer()
                Text(String(format: "%.1f/10", score))
                    .font(.caption2.weight(.bold))
                    .foregroundColor(color)
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 8)
                    
                    Capsule()
                        .fill(color)
                        .frame(width: geo.size.width * CGFloat(score / 10.0), height: 8)
                }
            }
            .frame(height: 8)
        }
    }
}

#Preview {
    AnalyzerView()
}
