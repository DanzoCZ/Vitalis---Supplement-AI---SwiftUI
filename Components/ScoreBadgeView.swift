import SwiftUI

struct ScoreBadgeView: View {
    let score: Double
    var label: String? = nil
    var showMaxScore: Bool = false
    
    var color: Color {
        if score >= 9.0 { return DesignSystem.primary }
        if score >= 7.0 { return .orange }
        return .red
    }
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(alignment: .lastTextBaseline, spacing: 1) {
                Text(String(format: "%.1f", score))
                    .font(.system(.title3, design: .rounded).weight(.bold))
                    .foregroundColor(color)
                
                if showMaxScore {
                    Text("/10")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            if let label = label {
                Text(label)
                    .font(.caption2.weight(.medium))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .glassmorphism(cornerRadius: 12)
    }
}

#Preview {
    HStack {
        ScoreBadgeView(score: 9.5, label: "Quality", showMaxScore: true)
        ScoreBadgeView(score: 8.0, label: "Value")
        ScoreBadgeView(score: 6.5, label: "Clean")
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
