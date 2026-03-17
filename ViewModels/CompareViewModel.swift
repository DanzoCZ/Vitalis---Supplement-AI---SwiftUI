import Foundation
import Combine

@MainActor
class CompareViewModel: ObservableObject {
    @Published var searchResults: [Supplement] = []
    @Published var selectedForComparison: [Supplement] = []
    @Published var searchQuery: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSearch()
    }
    
    private func setupSearch() {
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] query in
                self?.performSearch(query: query)
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(query: String) {
        if query.isEmpty {
            searchResults = MockDataService.shared.supplements
        } else {
            searchResults = MockDataService.shared.supplements.filter {
                $0.name.localizedCaseInsensitiveContains(query) ||
                $0.brand.name.localizedCaseInsensitiveContains(query)
            }
        }
    }
    
    func toggleSelection(for supplement: Supplement) {
        if selectedForComparison.contains(supplement) {
            selectedForComparison.removeAll(where: { $0.id == supplement.id })
        } else if selectedForComparison.count < 3 {
            // Limit to 3 items for side-by-side UI consistency
            selectedForComparison.append(supplement)
        }
    }
    
    func isSelected(_ supplement: Supplement) -> Bool {
        selectedForComparison.contains(supplement)
    }
    
    func clearSelection() {
        selectedForComparison.removeAll()
    }
}
