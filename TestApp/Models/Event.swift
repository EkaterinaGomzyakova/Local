// Models/Event.swift

import Foundation

struct Event: Identifiable, Codable {
    let id: Int
    let name: String
    let eventDescription: String?   // переименовали, чтобы не конфликтовать
    let startDate: Date
    let endDate: Date?
    let location: String?
    let createdBy: Int

    enum CodingKeys: String, CodingKey {
        case id, name, location, createdBy = "created_by"
        case eventDescription = "description"
        case startDate       = "start_date"
        case endDate         = "end_date"
    }
}
