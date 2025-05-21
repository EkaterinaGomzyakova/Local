// HomeView.swift

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()

    @State private var selectedSegment = 0
    private let segments = ["События", "Встречи"]

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(spacing: 24) {
                        header
                        banner
                    }

                    LazyVStack(spacing: 24, pinnedViews: [.sectionHeaders]) {
                        Section(header: segmentPicker) {
                            if selectedSegment == 0 {
                                eventsSection
                            } else {
                                meetsSection
                            }
                        }
                    }
                    .padding(.bottom, 16)
                }

                if vm.isLoading {
                    ProgressView()
                        .padding(12)
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .shadow(radius: 4)
                }
            }
            .navigationBarHidden(true)
            .onAppear { vm.loadAll() }
            .alert("Ошибка", isPresented: Binding(
                get: { vm.errorMessage != nil },
                set: { _ in vm.errorMessage = nil }
            )) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(vm.errorMessage ?? "")
            }
        }
    }

    // MARK: — UI Helpers

    private var header: some View {
        HStack {
            Image("avatar_placeholder")
                .resizable().frame(width: 32, height: 32).clipShape(Circle())
            Spacer()
            Text("Вспышка").font(.custom("Chalkduster", size: 24))
            Spacer()
            Button { /* оповещения */ } label: {
                Image(systemName: "bell").font(.title2).foregroundColor(.primary)
            }
        }
        .padding(.horizontal).padding(.top, 8)
    }

    private var banner: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.purple.opacity(0.3))
            // … сюда коллаж …
        }
        .frame(height: 200).padding(.horizontal)
    }

    private var segmentPicker: some View {
        Picker("", selection: $selectedSegment) {
            ForEach(segments.indices, id: \.self) { i in
                Text(segments[i]).tag(i)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal).padding(.bottom, 8)
        .background(Color(.systemBackground))
    }

    private var eventsSection: some View {
        Group {
            SectionHeader(title: "ДЛЯ ТЕБЯ")
            if let first = vm.events.first {
                EventRow(event: first)
            }
            SectionHeader(title: "ПОПУЛЯРНЫЕ")
            ForEach(vm.events.dropFirst().prefix(2), id: \.id) { e in
                EventRow(event: e)
            }
            SectionHeader(title: "НОВЫЕ")
            ForEach(vm.events.dropFirst(3).prefix(2), id: \.id) { e in
                EventRow(event: e)
            }
        }
    }

    private var meetsSection: some View {
        Group {
            SectionHeader(title: "ДЛЯ ТЕБЯ")
            ForEach(vm.meets, id: \.id) { m in
                MeetRow(meet: m)
            }
        }
    }
}

// MARK: — Helper Views

private struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title).font(.headline).padding(.horizontal)
    }
}

private struct EventRow: View {
    let event: Event
    var body: some View {
        NavigationLink(destination: /* ваш EventDetailView */ Text(event.name)) {
            /* ваш EventCardView */ Text(event.name)
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
    }
}

private struct MeetRow: View {
    let meet: Meet
    var body: some View {
        NavigationLink(destination: /* ваш MeetDetailView */ Text(meet.topic)) {
            /* ваш MeetCardView */ Text(meet.topic)
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
    }
}
