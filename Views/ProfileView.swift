import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("John Doe")
                                .font(.title3.weight(.semibold))
                            Text("Biohacker Level 2")
                                .font(.caption)
                                .foregroundColor(DesignSystem.primary)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section("My Protocols") {
                    NavigationLink("Deep Sleep Stack") { Text("Stack details...") }
                    NavigationLink("Morning Focus") { Text("Stack details...") }
                }
                
                Section("Preferences") {
                    NavigationLink("Health Goals") { Text("Goals...") }
                    NavigationLink("Dietary Restrictions") { Text("Restrictions...") }
                }
                
                Section {
                    NavigationLink("Settings", destination: SettingsView())
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        List {
            Section("Appearance") {
                Toggle("Dark Mode", isOn: $isDarkMode)
            }
            
            Section("Account") {
                Text("Edit Profile")
                Text("Privacy & Data Analytics")
                Text("Sign Out")
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    ProfileView()
}
