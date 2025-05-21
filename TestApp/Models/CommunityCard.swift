import Foundation
struct CommunityCard: Identifiable {
    let id = UUID()
    let imageName: String
    let link: String
    let name: String
    let participants: Int
    let events: Int
    let tags: [String]
    let upcoming: [EventCard]
    let past: [EventCard]
}
