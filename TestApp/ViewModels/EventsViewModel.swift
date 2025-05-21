import Foundation
import Combine

@MainActor
class EventsViewModel: ObservableObject {
  @Published var events: [Event] = []
  @Published var isLoading = false
  @Published var error: String?

  func load() {
    isLoading = true
    Task {
      EventService.shared.fetchEvents(page: 1) { result in
        self.isLoading = false
        switch result {
        case .success(let list):
          self.events = list
        case .failure(let err):
          self.error = "\(err)"
        }
      }
    }
  }
}
