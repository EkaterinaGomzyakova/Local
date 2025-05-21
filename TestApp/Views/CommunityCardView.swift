import SwiftUI

/// Компактная карточка сообщества, ведёт на экран деталей
struct CommunityCardView: View {
    let community: CommunityCard  // теперь используем ваш тип CommunityCard

    var body: some View {
        NavigationLink {
            CommunityDetailView(community: community)
        } label: {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
                    .frame(height: 200)

                Image(community.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .offset(y: -50)
            }
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#if DEBUG
struct CommunityCardView_Previews: PreviewProvider {
    static let sample = CommunityCard(
        imageName: "studsoyuz",
        link: "t.me/studsoyuz",
        name: "СТУДЕНЧЕСКИЙ\nСОЮЗ ФКИ",
        participants: 19,
        events: 2,
        tags: ["🎭 Развлечения", "🎨 Искусство", "💼 Карьера"],
        upcoming: [],
        past: []
    )
    static var previews: some View {
        NavigationView {
            CommunityCardView(community: sample)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif

