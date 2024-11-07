//
//  AddCardView.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import SwiftUI

struct AddCardView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var cards: [Card]
    @Binding var isPresented: Bool // Binding для управления модальным окном
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var tags: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Card Information")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    TextField("Tags (comma separated)", text: $tags)
                }
                
                Button("Add Card") {
                    let tagList = tags.split(separator: ",").map {
                        String($0).trimmingCharacters(in: .whitespaces)
                    }
                    let newCard = Card(title: title, description: description, tags: tagList)
                    cards.append(newCard)
                    isPresented = false // Закрываем экран после добавления карточки
                }
            }
            .navigationBarTitle("Add Card")
            .navigationBarItems(trailing: Button("Done") {
                isPresented = false // Закрытие модального окна
                // Закрытие модального окна
            })
        }
    }
}

// Пример превью с фиктивными данными
#Preview {
    AddCardView(cards: .constant([
        Card(title: "Example Card", description: "Example Description", tags: ["Tag1", "Tag2"])
    ]), isPresented: .constant(true))
    .environmentObject(ThemeManager())
}



