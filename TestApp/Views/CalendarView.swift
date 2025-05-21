//
//  CalendarView.swift
//  TestApp
//
//  Created by Kate on 04.03.2025.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date

    private let calendar = Calendar.current
    private let daysToShow = 7

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0..<daysToShow, id: \.self) { offset in
                    let date = calendar.date(byAdding: .day, value: offset, to: Date())!
                    let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)

                    VStack {
                        Text(date, format: .dateTime.weekday(.short))
                            .font(.caption)
                            .foregroundStyle(isSelected ? .white : .gray)

                        Text(date, format: .dateTime.day())
                            .font(.title2)
                            .bold()
                            .foregroundStyle(isSelected ? .white : .gray)
                    }
                    .padding()
                    .background(isSelected ? Color.blue : Color.clear)
                    .cornerRadius(12)
                    .onTapGesture {
                        selectedDate = date
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
