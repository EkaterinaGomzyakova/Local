//
//  CardView.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var card: Card

    var body: some View {
        VStack(alignment: .leading) {
            Text(card.title)
                .font(.headline)
            Text(card.description)
                .font(.subheadline)
                .lineLimit(2)
                .padding(.top, 5)
            HStack {
                ForEach(card.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    CardView(card: Card(title: "Sample Card", description: "This is a sample description", tags: ["Tag1", "Tag2"]))
        .environmentObject(ThemeManager())  // Добавляем объект ThemeManager для Preview
}

