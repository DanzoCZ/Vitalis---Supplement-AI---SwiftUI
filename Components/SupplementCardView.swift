import SwiftUI

struct SupplementCardView: View {
    let supplement: Supplement
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header: Icon + Brand
            HStack {
                Image(systemName: supplement.imageUrl ?? supplement.type.iconName)
                    .font(.title2)
                    .foregroundColor(DesignSystem.primary)
                    .frame(width: 44, height: 44)
                    .background(DesignSystem.primary.opacity(0.1))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(supplement.brand.name)
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.secondary)
                    
                    Text(supplement.name)
                        .vHeadlineStyle()
                }
                
                Spacer()
                
                // Overall Score Badge
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", supplement.overallScore))
                        .font(.subheadline.weight(.bold))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .glassmorphism(cornerRadius: 12, opacity: 0.2)
            }
            
            // Tags (Effects)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(supplement.effects.prefix(3)) { effect in
                        HStack(spacing: 4) {
                            Image(systemName: effect.iconName)
                                .font(.caption2)
                            Text(effect.rawValue)
                                .font(.caption2.weight(.medium))
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(DesignSystem.secondary.opacity(0.1))
                        .foregroundColor(DesignSystem.secondary)
                        .clipShape(Capsule())
                    }
                }
            }
            
            Divider()
                .background(Color.gray.opacity(0.3))
            
            // Footer: Price and Type
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Total Price")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(String(format: "$%.2f", supplement.price))
                        .font(.subheadline.weight(.semibold))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Per Serving")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(String(format: "$%.2f", supplement.pricePerServing))
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(DesignSystem.primary)
                }
            }
        }
        .padding(16)
        .glassmorphism(cornerRadius: 20, opacity: 0.1)
    }
}

#Preview {
    SupplementCardView(supplement: MockDataService.shared.supplements[0])
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all)) // To see glassmorphism better
}
