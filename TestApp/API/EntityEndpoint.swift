import Foundation

// Протокол Endpoint
protocol Endpoint {
    var compositePath: String { get }
    var headers: [String: String] { get }
    var parameters: [String: String]? { get }
}

// Реализация параметров по умолчанию для Endpoint
extension Endpoint {
    var parameters: [String: String]? {
        return nil // Параметры по умолчанию пустые
    }
}

// Определение различных эндпоинтов с параметрами
enum EntityEndpoint: Endpoint {
    case events(page: Int)
    case eventDetail(id: Int)
    case meets(page: Int, userId: Int?)
    case meetDetail(id: Int)
    case faculties(page: Int)
    case facultyDetail(id: Int)
    case communities(page: Int)
    case communityDetail(id: Int)

    // Определяем путь для каждого эндпоинта
    var compositePath: String {
        switch self {
        case .events:
            return "/api/v1/events"
        case .eventDetail(let id):
            return "/api/v1/events/\(id)"
        case .meets:
            return "/api/v1/meets"
        case .meetDetail(let id):
            return "/api/v1/meets/\(id)"
        case .faculties:
            return "/api/v1/faculties"
        case .facultyDetail(let id):
            return "/api/v1/faculties/\(id)"
        case .communities:
            return "/api/v1/communities"
        case .communityDetail(let id):
            return "/api/v1/communities/\(id)"
        @unknown default:
            return "/api/v1/default"  // Возвращаем путь по умолчанию на случай новых вариантов в будущем
        }
    }

    // Определяем параметры для каждого эндпоинта
    var parameters: [String: String]? {
        switch self {
        case .events(let page):
            return ["page": "\(page)"]
        case .meets(let page, let userId):
            var params = ["page": "\(page)"]
            if let userId = userId {
                params["user_id"] = "\(userId)"
            }
            return params
        case .faculties(let page):
            return ["page": "\(page)"]
        case .communities(let page):
            return ["page": "\(page)"]
        default:
            return nil
        }
    }

    // Заголовки для всех эндпоинтов
    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json" // формат джсон
        ]
    }
}

