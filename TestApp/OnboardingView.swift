//
//  OnboardingView.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import SwiftUI

struct OnboardingView: View {
    let pages = [
        OnboardingData(image: "img1", title: "Привет!", description: "Добро пожаловать!"),
        OnboardingData(image: "img2", title: "Функции", description: "Откройте новые функции"),
        OnboardingData(image: "img3", title: "Начнем", description: "Давайте начнем")
    ]
    
    @State private var currentPage = 0
    @Binding var onboardingCompleted: Bool  // Получает статус завершения онбординга

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    VStack {
                        Image(pages[index].image)
                        Text(pages[index].title).font(.largeTitle)
                        Text(pages[index].description).font(.body)
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
                }
                Spacer()
                if currentPage < pages.count - 1 {
                    Button("Далее") {
                        currentPage += 1
                    }
                } else {
                    Button("Начать") {
                        onboardingCompleted = true // Завершить онбординг
                    }
                }
            }
            .padding()
        }
    }
}
#Preview {
    @State var onboardingCompleted = false  // Добавляем переменную состояния для привязки

    return OnboardingView(onboardingCompleted: $onboardingCompleted)
        .environmentObject(ThemeManager())
}

