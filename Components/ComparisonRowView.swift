import SwiftUI

struct ComparisonRowView: View {
    let title: String
    let value1: String
    let value2: String
    var highlightBest: ComparisonHighlight = .none
    
    enum ComparisonHighlight {
        case none
        case higherIsBetter
        case lowerIsBetter
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.caption.weight(.medium))
                .foregroundColor(.secondary)
            
            HStack(spacing: 16) {
                // Item 1
                Text(value1)
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(colorForValue1())
                
                Divider()
                    .frame(height: 20)
                
                // Item 2
                Text(value2)
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(colorForValue2())
            }
        }
        .padding(.vertical, 12)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
    
    // Simple logic for highlighting numeric values
    private func colorForValue1() -> Color {
        guard highlightBest != .none,
              let v1 = Double(value1.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)),
              let v2 = Double(value2.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)) else {
            return .primary
        }
        
        if highlightBest == .higherIsBetter {
            return v1 > v2 ? DesignSystem.primary : .primary
        } else {
            return v1 < v2 ? DesignSystem.primary : .primary
        }
    }
    
    private func colorForValue2() -> Color {
        guard highlightBest != .none,
              let v1 = Double(value1.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)),
              let v2 = Double(value2.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)) else {
            return .primary
        }
        
        if highlightBest == .higherIsBetter {
            return v2 > v1 ? DesignSystem.primary : .primary
        } else {
            return v2 < v1 ? DesignSystem.primary : .primary
        }
    }
}

#Preview {
    VStack {
        ComparisonRowView(title: "Price per Serving", value1: "$0.50", value2: "$0.30", highlightBest: .lowerIsBetter)
        ComparisonRowView(title: "Overall Score", value1: "9.5", value2: "8.0", highlightBest: .higherIsBetter)
        ComparisonRowView(title: "Type", value1: "Capsule", value2: "Powder", highlightBest: .none)
    }
    .padding()
}
