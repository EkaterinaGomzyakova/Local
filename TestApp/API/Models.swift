import Foundation

// MARK: - Event
struct Event: Codable {
    let id: Int
    let name: String
    let description: String?
    let startDate: String
    let endDate: String?
    let location: String?
    let createdBy: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case startDate = "start_date"
        case endDate = "end_date"
        case location
        case createdBy = "created_by"
    }
}

// MARK: - Meet
struct Meet: Codable {
    let id: Int
    let topic: String
    let description: String?
    let scheduledAt: String
    let location: String?
    let hostId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case topic
        case description
        case scheduledAt = "scheduled_at"
        case location
        case hostId = "host_id"
    }
}

// MARK: - Faculty
struct Faculty: Codable {
    let id: Int
    let name: String
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
    }
}

// MARK: - Community
struct Community: Codable {
    let id: Int
    let name: String
    let description: String?
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case createdAt = "created_at"
    }
}

