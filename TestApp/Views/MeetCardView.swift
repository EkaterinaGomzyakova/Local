import SwiftUI

struct MeetCardView: View {
    let meet: MeetCard

    // простой форматтер для даты
    private let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        return f
    }()

    var body: some View {
        NavigationLink {
            MeetDetailView(meet: meet)
        } label: {
            VStack(alignment: .leading, spacing: 12) {
                // Дата и локация + закладка
                HStack(spacing: 12) {
                    CapsulePill(icon: "clock", text: dateFormatter.string(from: meet.date))
                    CapsulePill(icon: "mappin.and.ellipse", text: "Онлайн")
                    Spacer()
                    Button {
                        // TODO: bookmark toggle
                    } label: {
                        Image(systemName: "bookmark")
                            .font(.title3)
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.primary.opacity(0.5), lineWidth: 1)
                            )
                    }
                }

                // Описание встречи
                Text(meet.description)
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)

                // Количество участников (первые 3 аватара + "+N")
                HStack(spacing: -10) {
                    ForEach(0..<3) { i in
                        Image("avatar\(i+1)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    }
                    Text("+\(meet.participants > 3 ? meet.participants - 3 : 0)")
                        .font(.subheadline).bold()
                        .foregroundColor(.primary)
                        .padding(.leading, 8)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 4)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

private struct CapsulePill: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
            Text(text)
        }
        .font(.subheadline)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.primary.opacity(0.5), lineWidth: 1)
        )
    }
}

struct MeetCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MeetCardView(meet: MeetCard(
                description: "Обсуждаем новые возможности SwiftUI",
                date: Date().addingTimeInterval(3600),
                participants: 12
            ))
            .padding()
        }
    }
}

