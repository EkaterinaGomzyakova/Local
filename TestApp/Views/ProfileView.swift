import SwiftUI

struct ProfileView: View {
    // MARK: — тестовые данные
    @State private var user = UserProfile(
        firstName: "Анна", lastName: "Анчоусова",
        email: "anna@example.com",
        avatar: UIImage(named: "avatar_placeholder")
    )
    private let bio = "Супер смешная девчонка, люблю тусовки, Тейлор Свифт и Twenty One Pilots ;__)"
    private let interests = ["Дизайн", "Музыка", "Карьера"]
    private let followers = ["avatar1","avatar2","avatar3","avatar4","avatar5"]
    private let communities = ["community1","community2","community3","community4"]
    
    // MARK: — флаг для показа SettingsView
    @State private var showSettings = false
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    // — Header
                    ZStack(alignment: .top) {
                        // фон
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color(.systemGray6))
                            .frame(height: 240)
                        
                        VStack(spacing: 12) {
                            Spacer().frame(height: 80) // отступ сверху
                            
                            // аватар
                            if let avatar = user.avatar {
                                Image(uiImage: avatar)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                    .shadow(radius: 5)
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 120, height: 120)
                            }
                            
                            // ник и имя
                            Text("@ANANCHOUS")
                                .font(.title2)
                                .fontWeight(.black)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .clipShape(Capsule())
                            
                            Text("\(user.firstName) \(user.lastName)")
                                .font(.headline)
                            
                            // био
                            Text(bio)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                            
                            // иконки
                            HStack(spacing: 32) {
                                // Настройки — теперь открывает модальный лист
                                Button {
                                    showSettings.toggle()
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                        .foregroundColor(.black)
                                        .font(.title2)
                                }
                                
                                Button { /* Уведомления */ } label: {
                                    Image(systemName: "bell.fill")
                                        .foregroundColor(.black)
                                        .font(.title2)
                                }
                            }
                            .padding(.top, 8)
                        }
                    }
                    .padding(.top, -80)   // чтобы аватар свисал
                    .padding(.bottom, 16)
                    
                    // — Интересы
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Интересы")
                            .font(.headline)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(interests, id: \.self) { interest in
                                    Text(interest)
                                        .font(.caption)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color(.systemGray6))
                                        .clipShape(Capsule())
                                }
                                Button(action: { /* добавить */ }) {
                                    Image(systemName: "plus")
                                        .foregroundColor(.black)
                                        .padding(8)
                                        .background(Color(.systemGray6))
                                        .clipShape(Circle())
                                }
                            }
                        }
                    }
                    
                    // — Подписчики
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Подписчики")
                            .font(.headline)
                        HStack(spacing: -10) {
                            ForEach(followers.prefix(3), id: \.self) { name in
                                Image(name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            }
                            Text("+\(followers.count - 3)")
                                .font(.caption)
                                .foregroundColor(.black)
                                .padding(6)
                                .background(Color(.systemGray6))
                                .clipShape(Capsule())
                        }
                    }
                    
                    // — Сообщества
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Сообщества")
                            .font(.headline)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(communities, id: \.self) { img in
                                    Image(img)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                    }
                    
                    // — Список событий (используем ваш EventCardView)
                    VStack(spacing: 16) {
                    
                    }
                } // VStack
                .padding(.horizontal)
                .padding(.bottom, 16)
            } // ScrollView
            .padding(.vertical, 8)
            .background(Color.white)
            
            // собственный таб-бар, если нужен…
        } // VStack
        .edgesIgnoringSafeArea(.bottom)
        // Шаг 4: sheet для SettingsView
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
    
    // тестовые события
    private var sampleEvents: [EventCard] = [
        EventCard(
            title: "Дизайн для потребителей в эпоху перемен",
            description: "...",
            tags: ["Дизайн"],
            date: Date(),
            imageName: "eventImage",
            username: "dimaast"
        ),
        EventCard(
            title: "Дизайн для потребителей в эпоху перемен",
            description: "...",
            tags: ["Дизайн"],
            date: Date(),
            imageName: "eventImage",
            username: "dimaast"
        )
    ]
}

// Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

