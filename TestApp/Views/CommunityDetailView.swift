import SwiftUI

/// Детальный экран сообщества
struct CommunityDetailView: View {
    @Environment(\.presentationMode) private var presentationMode
    let community: CommunityCard  // также CommunityCard

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Заголовок с фоном
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.purple.opacity(0.3))
                        .frame(height: 200)

                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .padding(8)
                            .background(Color(.systemGray5))
                            .clipShape(Circle())
                    }
                    .padding()
                }

                // Аватарка, ссылка, название и статистика
                VStack(spacing: 8) {
                    Image(community.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .offset(y: -60)
                        .padding(.bottom, -60)

                    Text(community.link)
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)

                    Text(community.name)
                        .font(.title2).fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    HStack {
                        Spacer()
                        VStack {
                            Text("\(community.participants)")
                                .font(.headline)
                            Text("участников")
                                .font(.caption).foregroundColor(.gray)
                        }
                        Spacer()
                        VStack {
                            Text("\(community.events)")
                                .font(.headline)
                            Text("события")
                                .font(.caption).foregroundColor(.gray)
                        }
                        Spacer()
                    }
                }

                // Теги
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(community.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color(.systemGray5))
                                .clipShape(Capsule())
                        }
                    }
                    .padding(.horizontal)
                }

                // Кнопка «Подписаться»
                Button("Подписаться") {
                    // TODO: логика подписки
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .cornerRadius(12)
                .padding(.horizontal)

                // Предстоящие события
                VStack(alignment: .leading, spacing: 8) {
                    Text("ПРЕДСТОЯЩИЕ")
                        .font(.headline)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(community.upcoming, id: \.self) { event in
                                EventCardView(eventcard: event)
                                    .frame(width: 300)
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                // Прошедшие события
                VStack(alignment: .leading, spacing: 8) {
                    Text("ПРОШЕДШИЕ")
                        .font(.headline)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(community.past, id: \.self) { event in
                                EventCardView(eventcard: event)
                                    .opacity(0.4)
                                    .frame(width: 300)
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                Spacer(minLength: 40)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct CommunityDetailView_Previews: PreviewProvider {
    static let sample = CommunityCard(
        imageName: "studsoyuz",
        link: "t.me/studsoyuz",
        name: "СТУДЕНЧЕСКИЙ\nСОЮЗ ФКИ",
        participants: 19,
        events: 2,
        tags: ["🎭 Развлечения","🎨 Искусство"],
        upcoming: [],
        past: []
    )
    static var previews: some View {
        NavigationView {
            CommunityDetailView(community: sample)
        }
    }
}
#endif

