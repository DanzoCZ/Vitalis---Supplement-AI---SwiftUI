import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    let allSupplements = MockDataService.shared.supplements
    
    var searchResults: [Supplement] {
        if searchText.isEmpty {
            return allSupplements
        } else {
            return allSupplements.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.brand.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(searchResults) { supplement in
                NavigationLink(destination: SupplementDetailView(supplement: supplement)) {
                    HStack(spacing: 16) {
                        Image(systemName: supplement.imageUrl ?? supplement.type.iconName)
                            .font(.title3)
                            .foregroundColor(DesignSystem.primary)
                            .frame(width: 40, height: 40)
                            .background(DesignSystem.primary.opacity(0.1))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(supplement.name)
                                .font(.headline)
                            Text(supplement.brand.name)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        ScoreBadgeView(score: supplement.overallScore)
                            .scaleEffect(0.8)
                    }
                    .padding(.vertical, 4)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search supplements, brands...")
        }
    }
}

#Preview {
    SearchView()
}
