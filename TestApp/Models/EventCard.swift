import Foundation

struct EventCard: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let tags: [String]
    let date: Date
    let imageName: String
    let username: String
    var isFavorite: Bool = false
    var isAttending: Bool = false
    var isCreatedByUser: Bool = false
    var isPast: Bool = false
}

