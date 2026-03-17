import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Text("Sign In")
                .vTitleStyle()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
            }
            
            Button("Forgot Password?") {
                // Action
            }
            .font(.caption.weight(.medium))
            .foregroundColor(DesignSystem.primary)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Button(action: {
                withAnimation {
                    isLoggedIn = true
                }
            }) {
                Text("Login")
                    .vHeadlineStyle()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(DesignSystem.primaryGradient)
                    .cornerRadius(16)
            }
            .padding(.top, 8)
            
            Spacer()
            
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.secondary)
                Button("Sign Up") {
                    // Action
                }
                .foregroundColor(DesignSystem.primary)
                .fontWeight(.bold)
            }
            .font(.subheadline)
            .padding(.bottom, 20)
        }
        .padding(24)
        .background(DesignSystem.background.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}
