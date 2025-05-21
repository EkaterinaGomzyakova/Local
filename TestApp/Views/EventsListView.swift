import SwiftUI

struct EventsListView: View {
  @StateObject private var vm = EventsViewModel()
  @State private var showError = false

  var body: some View {
    NavigationView {
      List(vm.events, id: \.id) { event in    // ← указали id:\.id
        Text(event.title)
      }
      .navigationTitle("Events")
      .onAppear { vm.load() }
      .overlay {
        if vm.isLoading {
          ProgressView()
        }
      }
      .onChange(of: vm.error) { newError in   // следим за изменениями строки ошибки
        showError = newError != nil
      }
      .alert("Error", isPresented: $showError) {
        Button("OK") {
          vm.error = nil
        }
      } message: {
        Text(vm.error ?? "Unknown error")
      }
    }
  }
}
