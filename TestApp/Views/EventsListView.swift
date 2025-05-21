import SwiftUI

struct EventsListView: View {
  @StateObject private var vm = EventsViewModel()

  var body: some View {
    NavigationView {
      List(vm.events, id: \.id) { event in
        NavigationLink(destination: Text(event.eventDescription ?? "")) {
          Text(event.name)
        }
      }
      .navigationTitle("События")
      .task { vm.load() }
      .overlay {
        if vm.isLoading { ProgressView() }
      }
      .alert("Ошибка", isPresented: Binding(
        get: { vm.error != nil },
        set: { _ in vm.error = nil }
      )) {
        Button("OK", role: .cancel) {}
      } message: {
        Text(vm.error ?? "")
      }
    }
  }
}
