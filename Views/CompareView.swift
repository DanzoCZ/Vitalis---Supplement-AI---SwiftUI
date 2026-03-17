import SwiftUI

struct CompareView: View {
    @StateObject private var viewModel = CompareViewModel()
    @State private var showingSearch = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.selectedForComparison.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "scale.3d")
                            .font(.system(size: 60))
                            .foregroundColor(.secondary)
                        Text("Compare Supplements")
                            .vTitleStyle()
                        Text("Select up to 3 supplements to compare side-by-side.")
                            .vBodyStyle()
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Button("Select Supplements") {
                            showingSearch = true
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(DesignSystem.primary)
                    }
                    .padding()
                } else {
                    ComparisonTableView(supplements: viewModel.selectedForComparison) { supp in
                        viewModel.toggleSelection(for: supp)
                    }
                }
            }
            .navigationTitle("Compare")
            .toolbar {
                if !viewModel.selectedForComparison.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingSearch = true }) {
                            Image(systemName: "plus")
                        }
                        .disabled(viewModel.selectedForComparison.count >= 3)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Clear") { viewModel.clearSelection() }
                            .foregroundColor(.red)
                    }
                }
            }
            .sheet(isPresented: $showingSearch) {
                CompareSelectionSheet(viewModel: viewModel)
            }
        }
    }
}

struct ComparisonTableView: View {
    let supplements: [Supplement]
    let onRemove: (Supplement) -> Void
    
    var body: some View {
        ScrollView {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Headers
                    HStack(spacing: 16) {
                        EmptyView().frame(width: 100) // Label column width
                        ForEach(supplements) { supp in
                            VStack {
                                Image(systemName: supp.imageUrl ?? supp.type.iconName)
                                    .font(.title)
                                    .foregroundColor(DesignSystem.primary)
                                    .frame(width: 50, height: 50)
                                    .background(DesignSystem.primary.opacity(0.1))
                                    .clipShape(Circle())
                                
                                Text(supp.name)
                                    .font(.caption.weight(.bold))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                
                                Button(action: { onRemove(supp) }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                            .frame(width: 120)
                        }
                    }
                    .padding(.top)
                    
                    Divider()
                    
                    // Scores Matrix
                    CompareRowGroup(title: "Scores") {
                        MetricRow(label: "Overall", values: supplements.map { String(format: "%.1f", $0.overallScore) }, bestIndex: bestIndex(for: supplements.map { $0.overallScore }, higherIsBetter: true))
                        MetricRow(label: "Quality", values: supplements.map { String(format: "%.1f", $0.ingredientQualityScore) }, bestIndex: bestIndex(for: supplements.map { $0.ingredientQualityScore }, higherIsBetter: true))
                        MetricRow(label: "Clean Label", values: supplements.map { String(format: "%.1f", $0.cleanLabelScore) }, bestIndex: bestIndex(for: supplements.map { $0.cleanLabelScore }, higherIsBetter: true))
                    }
                    
                    // Details Matrix
                    CompareRowGroup(title: "Details") {
                        StringRow(label: "Type", values: supplements.map { $0.type.rawValue })
                        StringRow(label: "Servings", values: supplements.map { "\($0.servings)" })
                        MetricRow(label: "Price/Serving", values: supplements.map { String(format: "$%.2f", $0.pricePerServing) }, bestIndex: bestIndex(for: supplements.map { $0.pricePerServing }, higherIsBetter: false))
                    }
                }
                .padding()
            }
        }
    }
    
    private func bestIndex(for values: [Double], higherIsBetter: Bool) -> Int? {
        guard !values.isEmpty else { return nil }
        let target = higherIsBetter ? values.max() : values.min()
        return values.firstIndex(of: target!)
    }
}

// Helper Views for ComparisonTableView
struct CompareRowGroup<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .vHeadlineStyle()
                .foregroundColor(DesignSystem.primary)
            
            VStack(spacing: 8) {
                content
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
        }
    }
}

struct MetricRow: View {
    let label: String
    let values: [String]
    let bestIndex: Int?
    
    var body: some View {
        HStack(spacing: 16) {
            Text(label)
                .font(.caption.weight(.medium))
                .foregroundColor(.secondary)
                .frame(width: 100, alignment: .leading)
            
            ForEach(0..<values.count, id: \.self) { index in
                Text(values[index])
                    .font(.subheadline.weight(.bold))
                    .foregroundColor(bestIndex == index ? DesignSystem.primary : .primary)
                    .frame(width: 120, alignment: .center)
            }
        }
        .padding(.vertical, 4)
    }
}

struct StringRow: View {
    let label: String
    let values: [String]
    
    var body: some View {
        HStack(spacing: 16) {
            Text(label)
                .font(.caption.weight(.medium))
                .foregroundColor(.secondary)
                .frame(width: 100, alignment: .leading)
            
            ForEach(0..<values.count, id: \.self) { index in
                Text(values[index])
                    .font(.caption)
                    .frame(width: 120, alignment: .center)
            }
        }
        .padding(.vertical, 4)
    }
}


struct CompareSelectionSheet: View {
    @ObservedObject var viewModel: CompareViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List(viewModel.searchResults) { supplement in
                HStack {
                    VStack(alignment: .leading) {
                        Text(supplement.name).font(.headline)
                        Text(supplement.brand.name).font(.caption).foregroundColor(.secondary)
                    }
                    Spacer()
                    
                    if viewModel.isSelected(supplement) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(DesignSystem.primary)
                    } else if viewModel.selectedForComparison.count < 3 {
                        Image(systemName: "circle")
                            .foregroundColor(.secondary)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.toggleSelection(for: supplement)
                }
            }
            .searchable(text: $viewModel.searchQuery, prompt: "Search to compare...")
            .navigationTitle("Select Supplements")
            .navigationBarItems(trailing: Button("Done") { dismiss() })
            // Show selection count
            .safeAreaInset(edge: .bottom) {
                if !viewModel.selectedForComparison.isEmpty {
                    Text("\(viewModel.selectedForComparison.count)/3 Selected")
                        .font(.caption.weight(.bold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(DesignSystem.primaryGradient)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    CompareView()
}
