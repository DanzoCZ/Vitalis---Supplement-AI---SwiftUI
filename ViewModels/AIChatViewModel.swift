import Foundation
import Combine

@MainActor
class AIChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var inputText: String = ""
    @Published var isThinking: Bool = false
    
    init() {
        // Initial welcome message
        messages.append(ChatMessage(text: "Hi! I'm Vitalis, your AI supplement advisor. How can I help you today?", isUser: false))
    }
    
    func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let userMessage = ChatMessage(text: inputText, isUser: true)
        messages.append(userMessage)
        
        let currentInput = inputText
        inputText = ""
        isThinking = true
        
        Task {
            do {
                let responseText = try await AIAssistantService.shared.getResponse(for: currentInput)
                let aiMessage = ChatMessage(text: responseText, isUser: false)
                messages.append(aiMessage)
                isThinking = false
            } catch {
                let errorMessage = ChatMessage(text: "Sorry, I encountered an error. Please try again.", isUser: false)
                messages.append(errorMessage)
                isThinking = false
            }
        }
    }
}
