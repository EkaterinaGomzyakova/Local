import SwiftUI

struct MeetDetailView: View {
    @Environment(\.presentationMode) private var presentationMode
    let meet: MeetCard

    @State private var comments: [String] = []
    @State private var newComment: String = ""

    private let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        return f
    }()

    var body: some View {
        VStack(spacing: 16) {
            // Навигационный бар
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .padding(8)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }

                Spacer()

                CapsulePill(icon: "clock", text: dateFormatter.string(from: meet.date))

                Spacer()

                HStack(spacing: 4) {
                    Text("\(meet.participants)")
                        .font(.headline)
                    Image(systemName: "chevron.right")
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.primary.opacity(0.5), lineWidth: 1)
                )
            }
            .padding()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Описание встречи
                    Text(meet.description)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .fixedSize(horizontal: false, vertical: true)

                    // Местоположение
                    Text("Малая Пионерская, 12")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    // Участники
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

                    // Комментарии
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Комментарии")
                            .font(.headline)

                        if comments.isEmpty {
                            Text("Пока нет комментариев")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                        }

                        HStack {
                            TextField("Оставить комментарий", text: $newComment)
                                .padding(12)
                                .background(Color(.systemGray6))
                                .cornerRadius(25)

                            Button {
                                guard !newComment.isEmpty else { return }
                                comments.append(newComment)
                                newComment = ""
                            } label: {
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding(.horizontal)

                    Spacer(minLength: 50)
                }
                .padding(.horizontal)
            }

            // Кнопка «Пойду»
            Button("Пойду") {
                // TODO: зарегистрироваться
            }
            .foregroundColor(.white)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .cornerRadius(12)
            .padding(.horizontal)
            .padding(.bottom,
                     UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0 + 8)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// Вспомогательная капсула
private struct CapsulePill: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
            Text(text)
                .lineLimit(1)
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

struct MeetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MeetDetailView(meet: MeetCard(
                description: "Обсуждаем новые возможности SwiftUI",
                date: Date().addingTimeInterval(3600),
                participants: 12
            ))
        }
    }
}

