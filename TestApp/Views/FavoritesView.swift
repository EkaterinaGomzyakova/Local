import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favs: FavoritesManager
    @State private var selectedIndex = 0
    private let tabs = ["Избранное", "Иду", "Мои", "Архив"]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Сегментный контрол
                Picker("", selection: $selectedIndex) {
                    ForEach(tabs.indices, id: \.self) { idx in
                        Text(tabs[idx]).tag(idx)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.top)
                .accentColor(.purple)

                // Контент для каждой вкладки
                Group {
                    if selectedIndex == 0 {
                        // Вкладка «Избранное»
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                if favs.favorites.isEmpty {
                                    Text("Пока нет закладок")
                                        .foregroundColor(.gray)
                                        .padding(.top, 50)
                                } else {
                                    ForEach(favs.favorites) { event in
                                        NavigationLink(destination: EventDetailView(event: event).environmentObject(favs)) {
                                            FavoriteCardRow(event: event)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                            .padding()
                        }
                    } else {
                        Spacer()
                        Text("Пока пусто")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                .animation(.default, value: selectedIndex)
            }
            .navigationBarHidden(true)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FavoritesManager())
    }
}

