import Foundation

final class FavoritesManager: ObservableObject {
    @Published var favorites: [EventCard] = []
    
    func toggle(_ event: EventCard) {
        if let idx = favorites.firstIndex(of: event) {
            favorites.remove(at: idx)
        } else {
            favorites.append(event)
        }
    }
    
    func isFavorite(_ event: EventCard) -> Bool {
        favorites.contains(event)
    }
}
