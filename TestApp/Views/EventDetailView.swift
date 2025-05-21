import SwiftUI

struct EventDetailView: View {
    @Environment(\.presentationMode) private var presentationMode
    let event: EventCard
    
    // пример данных
    @State private var comments: [String] = []
    @State private var newComment: String = ""
    @State private var responsesCount: Int = 5
    @State private var isBookmarked: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            // MARK: — Навигационная шапка
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                        .padding(8)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                // Центральная «таблетка» с датой и временем
                Text(event.date, style: .date)
                    .font(.subheadline)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Capsule())
                
                Spacer()
                
                // Кнопка «закладка»
                Button {
                    isBookmarked.toggle()
                } label: {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.subheadline)
                        .foregroundColor(isBookmarked ? .blue : .primary)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
            }
            .padding()
            
            ScrollView {
                VStack(spacing: 16) {
                    // MARK: — Изображение
                    Image(event.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 240)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .background(Color.gray.opacity(0.1))
                    
                    // MARK: — Автор
                    HStack(spacing: 12) {
                        Image(event.imageName)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        Text("@\(event.username)")
                            .font(.subheadline).fontWeight(.medium)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // MARK: — Даты и режим
                    HStack {
                        Text("20 января – 1 февраля")
                        Spacer()
                        Text("Онлайн")
                    }
                    .font(.subheadline)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                    
                    // MARK: — Кнопки «отклики» и «позвать друзей»
                    HStack {
                        Text("\(responsesCount) откликов / ∞")
                            .font(.subheadline)
                        Spacer()
                        Button("Позвать друзей") {
                            // действие
                        }
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.3))
                        .foregroundColor(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .disabled(true)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                    
                    // MARK: — Описание
                    Text(event.description)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal)
                    
                    // MARK: — Комментарии
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Комментарии")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        if comments.isEmpty {
                            Text("Пока нет комментариев")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(12)
                                .padding(.horizontal)
                        }
                        
                        HStack {
                            TextField("Оставить комментарий", text: $newComment)
                                .padding(12)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(25)
                            
                            Button {
                                guard !newComment.isEmpty else { return }
                                comments.append(newComment)
                                newComment = ""
                            } label: {
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(.blue)
                                    .padding(.trailing, 12)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 16)
                    
                    Spacer(minLength: 50)
                }
                .padding(.vertical)
            }
            
            // MARK: — Кнопка «Регистрация»
            Button(action: {
                // зарегистрироваться
            }) {
                Text("Регистрация")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.bottom, safeAreaBottom() + 8)
            }
        }

    }
    
    private func safeAreaBottom() -> CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
}

