import SwiftUI

struct ChatBubbleView: View {
    let message: ChatMessage
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.isUser {
                Spacer(minLength: 40)
            } else {
                Image(systemName: "sparkles")
                    .font(.caption)
                    .foregroundColor(.white)
                    .frame(width: 28, height: 28)
                    .background(DesignSystem.primaryGradient)
                    .clipShape(Circle())
            }
            
            Text(message.text)
                .vBodyStyle()
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    message.isUser
                        ? AnyView(DesignSystem.primary.opacity(0.15))
                        : AnyView(Color(UIColor.secondarySystemBackground))
                )
                .foregroundColor(message.isUser ? .primary : .primary)
                .clipShape(ChatBubbleShape(isUser: message.isUser))
            
            if !message.isUser {
                Spacer(minLength: 40)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

struct ChatBubbleShape: Shape {
    let isUser: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [
                .topLeft,
                .topRight,
                isUser ? .bottomLeft : .bottomRight
            ],
            cornerRadii: CGSize(width: 16, height: 16)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    VStack {
        ChatBubbleView(message: ChatMessage(text: "Which Lion's Mane is best?", isUser: true))
        ChatBubbleView(message: ChatMessage(text: "For the purest quality, I recommend SuperionHerbs dual extract powder.", isUser: false))
    }
}
