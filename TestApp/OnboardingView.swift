//
//  OnboardingView.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import SwiftUI

struct OnboardingView: View {
    let pages = [
        OnboardingData(image: "firstOnbImg", title: "все ивенты", description: "и встречи Вышки в одном приложении"),
        OnboardingData(image: "img2", title: "выбирай", description: "что тебе интересно"),
        OnboardingData(image: "img3", title: "добавляй", description: "свои ивенты")
    ]

    let tags = [
        TagData(imageName: "tag1", text: "Музыка"),
        TagData(imageName: "tag1", text: "Дизайн"),
        TagData(imageName: "tag1", text: "Спорт"),
        TagData(imageName: "tag1", text: "Карьера"),
        TagData(imageName: "tag1", text: "Бизнес"),
        TagData(imageName: "tag1", text: "Здоровье"),
        TagData(imageName: "tag1", text: "Искусство"),
        TagData(imageName: "tag1", text: "Развлечения"),
        TagData(imageName: "tag1", text: "Кино"),
    ]
    
    @State private var currentPage = 0
    @Binding var onboardingCompleted: Bool  // Получает статус завершения онбординга

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    ZStack {
                        // Фоновое изображение
                        Image("orbitBg")
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .ignoresSafeArea()
                        
                        // Основной контент
                        VStack(spacing: 20) {
                            Spacer()
                            Image(pages[index].image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 200, maxHeight: 200)
                        
                            Text(pages[index].title)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .bold()
                            Text(pages[index].description)
                                .font(.body)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)

                            // Отображаем теги только на втором экране
                            if index == 1 {
                                TagsGridView(tags: tags)
                            }

                            Spacer()
                        }
                        .padding()
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            HStack {
                if currentPage > 0 {
                    Button("Назад") {
                        currentPage -= 1
                    }
                    .padding(.horizontal)
                }
                Spacer()
                if currentPage < pages.count - 1 {
                    Button("Далее") {
                        currentPage += 1
                    }
                    .padding(.horizontal)
                } else {
                    Button("Начать") {
                        onboardingCompleted = true // Завершить онбординг
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
    }
}

struct TagData: Identifiable {
    let id = UUID()
    let imageName: String
    let text: String
}

struct TagsGridView: View {
    let tags: [TagData]

    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<6, id: \.self) { _ in
                HStack(spacing: 10) {
                    ForEach(getRandomTags(count: Int.random(in: 2...4))) { tag in
                        HStack(spacing: 6) {
                            Image(tag.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20) // Настраиваем размер изображения
                            Text(tag.text)
                                .font(.caption)
                        }
                        .padding(8)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    private func getRandomTags(count: Int) -> [TagData] {
        Array(tags.shuffled().prefix(count))
    }
}

#Preview {
    @State var onboardingCompleted = false  // Добавляем переменную состояния для привязки

    return OnboardingView(onboardingCompleted: $onboardingCompleted)
        .environmentObject(ThemeManager())
}
