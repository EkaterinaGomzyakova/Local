import SwiftUI

struct HomeView: View {
    // события
    @Binding var cards: [EventCard]
    // встречи
    @Binding var meets: [MeetCard]

    // сегмент «События / Встречи»
    @State private var selectedSegment = 0
    private let segments = ["События", "Встречи"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // MARK: — Header
                    HStack {
                        Image("avatar_placeholder")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                        Spacer()
                        Text("Вспышка")
                            .font(.custom("Chalkduster", size: 24))
                        Spacer()
                        Button {
                            // TODO: уведомления
                        } label: {
                            Image(systemName: "bell")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    // MARK: — Баннер/коллаж
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.purple.opacity(0.3))
                        // … ваш коллаж …
                    }
                    .frame(height: 200)
                    .padding(.horizontal)
                }

                // MARK: — Список с «залипающим» переключателем
                LazyVStack(spacing: 24, pinnedViews: [.sectionHeaders]) {
                    Section(header:
                        Picker("", selection: $selectedSegment) {
                            ForEach(segments.indices, id: \.self) { idx in
                                Text(segments[idx]).tag(idx)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .background(Color(.systemBackground))
                    ) {
                        if selectedSegment == 0 {
                            // СЕГМЕНТ «СОБЫТИЯ»
                            SectionHeader(title: "ДЛЯ ТЕБЯ")
                            if let first = cards.first {
                                EventRow(event: first)
                            }

                            SectionHeader(title: "ПОПУЛЯРНЫЕ")
                            ForEach(cards.dropFirst().prefix(2), id: \.id) { event in
                                EventRow(event: event)
                            }

                            SectionHeader(title: "НОВЫЕ")
                            ForEach(cards.dropFirst(3).prefix(2), id: \.id) { event in
                                EventRow(event: event)
                            }
                        } else {
                            // СЕГМЕНТ «ВСТРЕЧИ»
                            SectionHeader(title: "ДЛЯ ТЕБЯ")
                            ForEach(meets, id: \.id) { meet in
                                MeetRow(meet: meet)
                            }
                        }
                    }
                }
                .padding(.bottom, 16)
            }
            .navigationBarHidden(true)
        }
    }
}

// Заголовок секции
private struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .padding(.horizontal)
    }
}

// Ряд события
private struct EventRow: View {
    let event: EventCard
    var body: some View {
        NavigationLink(destination: EventDetailView(event: event)) {
            EventCardView(eventcard: event)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal)
    }
}

// Ряд встречи
private struct MeetRow: View {
    let meet: MeetCard
    var body: some View {
        NavigationLink(destination: MeetDetailView(meet: meet)) {
            MeetCardView(meet: meet)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal)
    }
}

// Превью
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            cards: .constant([
                EventCard(
                    title: "Дизайн для потребителей в эпоху перемен",
                    description: "...",
                    tags: ["Дизайн"],
                    date: Date(),
                    imageName: "eventImage",
                    username: "dimaast"
                )
            ]),
            meets: .constant([
                MeetCard(
                    description: "Обсуждаем новые фичи",
                    date: Date(),
                    participants: 10
                )
            ])
        )
    }
}

