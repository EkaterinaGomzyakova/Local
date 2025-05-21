import Foundation

// MARK: — Event


// MARK: — Meet
struct Meet: Identifiable, Codable {
    let id: Int
    let topic: String
    let body: String?         // вместо `description`
    let scheduledAt: Date
    let location: String?
    let hostId: Int

    enum CodingKeys: String, CodingKey {
        case id, topic
        case body           = "description"
        case scheduledAt    = "scheduled_at"
        case location
        case hostId         = "host_id"
    }
}

// MARK: — Faculty
struct Faculty: Identifiable, Codable {
    let id: Int
    let name: String
    let body: String?         // вместо `description`

    enum CodingKeys: String, CodingKey {
        case id, name
        case body           = "description"
    }
}

// MARK: — Community
struct Community: Identifiable, Codable {
    let id: Int
    let name: String
    let body: String?         // вместо `description`
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id, name
        case body           = "description"
        case createdAt      = "created_at"
    }
}

