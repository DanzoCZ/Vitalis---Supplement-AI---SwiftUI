import SwiftUI

struct ContentView: View {
    @State private var hasSeenOnboarding = false
    @State private var isLoggedIn = false
    
    var body: some View {
        Group {
            if !hasSeenOnboarding {
                OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
            } else if !isLoggedIn {
                LoginView(isLoggedIn: $isLoggedIn)
            } else {
                MainTabView()
            }
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(1)
            
            CompareView()
                .tabItem {
                    Label("Compare", systemImage: "scale.3d")
                }
                .tag(2)
            
            AIChatView()
                .tabItem {
                    Label("AI Advisor", systemImage: "sparkles")
                }
                .tag(3)
            
            AnalyzerView()
                .tabItem {
                    Label("Analyzer", systemImage: "waveform.path.ecg")
                }
                .tag(4)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .tag(5)
        }
        .tint(DesignSystem.primary)
    }
}

#Preview {
    ContentView()
}
