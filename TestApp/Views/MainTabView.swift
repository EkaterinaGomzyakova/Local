import SwiftUI

struct MainTabView: View {
    // 1️⃣ Менеджер избранного
    @StateObject private var favs = FavoritesManager()
    // 2️⃣ Текущая вкладка
    @State private var selectedTab: Int = 0
    // 3️⃣ Все события
    @State private var cards: [EventCard] = [
        EventCard(
            title: "Выставка современных художников",
            description: "Погрузитесь в мир современного искусства!",
            tags: ["🎨 Искусство","🖌️ Выставка"],
            date: Date(),
            imageName: "eventImage",
            username: "User1"
        )
    ]
    // 4️⃣ Все встречи
    @State private var meets: [MeetCard] = [
        MeetCard(
            description: "Обсуждаем новые возможности",
            date: Date().addingTimeInterval(3600),
            participants: 12
        )
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView(cards: $cards, meets: $meets)
                    .environmentObject(favs)
                    .tag(0)

                SearchView()
                    .environmentObject(favs)
                    .tag(1)

                AddView(cards: $cards)
                    .environmentObject(favs)
                    .tag(2)

                FavoritesView()
                    .environmentObject(favs)
                    .tag(3)

                ProfileView()
                    .environmentObject(favs)
                    .tag(4)
            }
            .edgesIgnoringSafeArea(.bottom)

            // Кастомный таб-бар
            VStack(spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                    TabBarItem(imageName: "house", isSelected: selectedTab == 0) { selectedTab = 0 }
                    TabBarItem(imageName: "magnifyingglass", isSelected: selectedTab == 1) { selectedTab = 1 }
                    TabBarItem(imageName: "plus", isSelected: selectedTab == 2) { selectedTab = 2 }
                    TabBarItem(imageName: "star", isSelected: selectedTab == 3) { selectedTab = 3 }
                    TabBarItem(imageName: "person", isSelected: selectedTab == 4) { selectedTab = 4 }
                }
                .padding(.horizontal)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.bottom, 10)
            }
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .font(.system(size: 20))
                .foregroundColor(isSelected ? .purple : .gray)
                .frame(maxWidth: .infinity, maxHeight: 50)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

