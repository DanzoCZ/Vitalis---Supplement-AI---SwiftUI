import SwiftUI

struct AIChatView: View {
    @StateObject private var viewModel = AIChatViewModel()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Chat sequence
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.messages) { message in
                                ChatBubbleView(message: message)
                                    .id(message.id)
                            }
                            
                            if viewModel.isThinking {
                                HStack {
                                    Image(systemName: "sparkles")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .frame(width: 28, height: 28)
                                        .background(DesignSystem.primaryGradient)
                                        .clipShape(Circle())
                                    
                                    HStack(spacing: 4) {
                                        Circle().fill(Color.gray).frame(width: 6, height: 6)
                                        Circle().fill(Color.gray).frame(width: 6, height: 6)
                                        Circle().fill(Color.gray).frame(width: 6, height: 6)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(Color(UIColor.secondarySystemBackground))
                                    .clipShape(ChatBubbleShape(isUser: false))
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 4)
                                .id("thinking")
                            }
                        }
                        .padding(.vertical)
                    }
                    .onChange(of: viewModel.messages.count) { _ in
                        withAnimation {
                            proxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                    .onChange(of: viewModel.isThinking) { thinking in
                        if thinking {
                            withAnimation {
                                proxy.scrollTo("thinking", anchor: .bottom)
                            }
                        }
                    }
                }
                
                // Input area
                VStack(spacing: 0) {
                    Divider()
                    HStack(spacing: 12) {
                        TextField("Ask Vitalis AI...", text: $viewModel.inputText, axis: .vertical)
                            .lineLimit(1...4)
                            .padding(12)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(20)
                            .focused($isFocused)
                        
                        Button(action: viewModel.sendMessage) {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : DesignSystem.primary)
                        }
                        .disabled(viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isThinking)
                    }
                    .padding()
                }
                .background(DesignSystem.background)
            }
            .navigationTitle("Vitalis Assistant")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AIChatView()
}
