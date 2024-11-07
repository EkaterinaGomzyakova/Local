//
//  MainTabView.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var selectedTab: Int = 0  // Хранит выбранную вкладку

    var body: some View {
        VStack {
            // Контент вкладок
            Group {
                if selectedTab == 0 {
                    ContentView()
                } else {
                    ProfileView()
                }
            }

            Spacer()  // Для того чтобы кастомный TabBar был внизу экрана

            // Кастомный TabBar
            CustomTabBar(selectedTab: $selectedTab)
                .background(themeManager.currentTheme.backgroundColor)  // Цвет фона кастомного TabBar
        }
        .edgesIgnoringSafeArea(.bottom)  // Игнорируем безопасную зону для TabBar
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int  // Получаем выбранную вкладку

    var body: some View {
        HStack {
            // Кнопка для вкладки "Cards"
            Button(action: {
                selectedTab = 0
            }) {
                Image(systemName: "list.bullet")
                    .font(.system(size: 24))
                    .foregroundColor(selectedTab == 0 ? .blue : .gray)
            }
            Spacer()

            // Кнопка для вкладки "Profile"
            Button(action: {
                selectedTab = 1
            }) {
                Image(systemName: "person.circle")
                    .font(.system(size: 24))
                    .foregroundColor(selectedTab == 1 ? .blue : .gray)
            }
        }
        .padding()
        .background(BlurView(style: .systemMaterialDark))  // Полупрозрачный фон
        .cornerRadius(25)  // Скругленные углы
        .padding([.leading, .trailing, .bottom], 10)
        .shadow(radius: 5)
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview {
    MainTabView()
        .environmentObject(ThemeManager())  // Добавляем объект ThemeManager для Preview
}
