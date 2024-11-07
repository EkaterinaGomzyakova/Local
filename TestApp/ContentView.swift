//
//  ContentView.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @AppStorage("onboardingCompleted") private var onboardingCompleted = false  // Сохраняет состояние завершения онбординга
    @State private var cards: [Card] = [
        Card(title: "Card 1", description: "Description for card 1", tags: ["Tag1", "Tag2"]),
        Card(title: "Card 2", description: "Description for card 2", tags: ["Tag3"])
    ]
    @State private var showModal = false
    @State private var selectedTag: String = "All"
    @State private var searchText: String = ""

    // Фильтрация карточек по тегу и поисковому запросу
    var filteredCards: [Card] {
        let filteredByTag = selectedTag == "All" ? cards : cards.filter { $0.tags.contains(selectedTag) }
        return searchText.isEmpty ? filteredByTag : filteredByTag.filter {
            $0.title.contains(searchText) || $0.description.contains(searchText)
        }
    }

    var uniqueTags: [String] {
        var tags = Set(cards.flatMap { $0.tags })
        tags.insert("All")
        return Array(tags)
    }

    var body: some View {
        if onboardingCompleted {
            mainContentView  // Показывает основной контент
        } else {
            OnboardingView(onboardingCompleted: $onboardingCompleted)  // Показывает онбординг
        }
    }

    // Основной контент приложения
    var mainContentView: some View {
        NavigationView {
            VStack {
                Picker("Filter by Tag", selection: $selectedTag) {
                    ForEach(uniqueTags, id: \.self) { tag in
                        Text(tag).tag(tag)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                TextField("Search", text: $searchText)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)

                List {
                    ForEach(filteredCards) { card in
                        CardView(card: card)
                    }
                    .onDelete(perform: deleteCard)
                }
            }
            .navigationBarTitle("Cards")
            .navigationBarItems(trailing: Button(action: { showModal.toggle() }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showModal) {
                AddCardView(cards: $cards, isPresented: $showModal)
                    .environmentObject(themeManager)
            }
        }
    }

    // Функция для удаления карточек
    func deleteCard(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
}


