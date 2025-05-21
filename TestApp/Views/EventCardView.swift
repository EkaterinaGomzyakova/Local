import SwiftUI

struct EventCardView: View {
    var eventcard: EventCard

    var body: some View {
        // Оборачиваем компактную карточку в NavigationLink
        NavigationLink(destination: EventDetailView(event: eventcard)) {
            VStack(alignment: .leading, spacing: 8) {
                // — Верхняя часть с изображением
                ZStack(alignment: .topLeading) {
                    Image(eventcard.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.3)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )

                    // Закладка
                    Image(systemName: "bookmark")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                        .padding(12)

                    // Аватары участников
                    HStack(spacing: -12) {
                        ForEach(0..<3) { i in
                            Image("avatar\(i+1)")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        }
                        Text("+17")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Capsule())
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(12)
                }

                // — Информация
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)
                        Text(eventcard.date, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        ForEach(eventcard.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .padding(6)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Capsule())
                        }
                    }

                    Text(eventcard.title)
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text("Создал: @\(eventcard.username)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 5)
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Превью
struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                EventCardView(eventcard: EventCard(
                    title: "Мастер-класс по созданию открыток из чеков",
                    description: "Тут будет описание",
                    tags: ["🎨 Искусство"],
                    date: Date(),
                    imageName: "exampleImage",
                    username: "dimaast"
                ))
                EventCardView(eventcard: EventCard(
                    title: "Мастер-класс по созданию открыток из чеков",
                    description: "Тут будет описание",
                    tags: ["🎨 Искусство"],
                    date: Date(),
                    imageName: "exampleImage",
                    username: "dimaast"
                ))
            }
        }
    }
}

#Preview {
    NavigationView {
        EventCardView(eventcard:
            EventCard(
                title: "Мастер-класс по созданию открыток из чеков",
                description: "Тут будет описание",
                tags: ["🎨 Искусство"],
                date: Date(),
                imageName: "exampleImage",
                username: "dimaast"
            )
        )
    }
}
