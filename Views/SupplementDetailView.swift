import SwiftUI

struct SupplementDetailView: View {
    let supplement: Supplement
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header image/icon area
                ZStack {
                    Circle()
                        .fill(DesignSystem.primary.opacity(0.1))
                        .frame(width: 140, height: 140)
                    
                    Image(systemName: supplement.imageUrl ?? supplement.type.iconName)
                        .font(.system(size: 60))
                        .foregroundColor(DesignSystem.primary)
                }
                .padding(.top, 20)
                
                // Titles
                VStack(spacing: 8) {
                    Text(supplement.brand.name)
                        .font(.subheadline.weight(.bold))
                        .foregroundColor(DesignSystem.primary)
                        .textCase(.uppercase)
                    
                    Text(supplement.name)
                        .font(.system(.title, design: .rounded).weight(.bold))
                        .multilineTextAlignment(.center)
                    
                    Text("Type: \(supplement.type.rawValue) • \(supplement.servings) Servings")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // Scores
                HStack(spacing: 16) {
                    ScoreBadgeView(score: supplement.overallScore, label: "Overall", showMaxScore: true)
                    ScoreBadgeView(score: supplement.ingredientQualityScore, label: "Quality")
                    ScoreBadgeView(score: supplement.cleanLabelScore, label: "Clean")
                    ScoreBadgeView(score: supplement.valueScore, label: "Value")
                }
                .padding(.horizontal)
                
                // Price Info
                HStack {
                    VStack(alignment: .leading) {
                        Text("Price")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(String(format: "$%.2f", supplement.price))
                            .font(.title3.weight(.semibold))
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Per Serving")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(String(format: "$%.2f", supplement.pricePerServing))
                            .font(.title3.weight(.semibold))
                            .foregroundColor(DesignSystem.primary)
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Ingredients Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Active Ingredients")
                        .vHeadlineStyle()
                    
                    ForEach(supplement.ingredients, id: \.id) { item in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(item.ingredient.name)
                                    .font(.subheadline.weight(.semibold))
                                Spacer()
                                Text(item.dosage.displayString)
                                    .font(.subheadline.weight(.bold))
                                    .foregroundColor(DesignSystem.primary)
                            }
                            
                            if let extract = item.extractRatio {
                                Text("Extract: \(extract)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Text(item.ingredient.description)
                                .font(.caption)
                                .foregroundColor(Color(UIColor.secondaryLabel))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding()
                        .glassmorphism(cornerRadius: 12)
                    }
                }
                .padding(.horizontal)
                
                Spacer(minLength: 40)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { /* Add to Compare */ }) {
                    Image(systemName: "scale.3d")
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        SupplementDetailView(supplement: MockDataService.shared.supplements[0])
    }
}
