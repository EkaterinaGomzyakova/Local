import Foundation
import Combine

class EventsViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var isLoading = false
    @Published var error: String?

    func load() {
        isLoading = true
        EventService.shared.fetchEvents(page: 1) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let list):   self.events = list
                case .failure(let err):    self.error = err.localizedDescription
                }
            }
        }
    }
}
