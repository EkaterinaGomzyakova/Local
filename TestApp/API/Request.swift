import Foundation

struct Request {
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
        case options = "OPTIONS"
    }
    
    var endpoint: Endpoint
    var method: Method
    var parameters: [String: String]?
    var timeout: TimeInterval
    var body: Data?
    
    // Инициализатор с параметрами запроса, методами и телом
    init(
        endpoint: Endpoint,
        method: Method = .get,
        parameters: [String: String]? = nil,
        timeout: TimeInterval = 60,
        body: Data? = nil
    ) {
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        self.timeout = timeout
        self.body = body
        
        // Добавляем параметры из endpoint в параметры запроса
        if var endpointParameters = endpoint.parameters {
            for (key, value) in parameters ?? [:] {
                endpointParameters[key] = value
            }
            self.parameters = endpointParameters
        }
    }
}

extension Request {
    // Генерация URL для запроса с учетом API Rails
    func generateURL(baseURL: String) -> URL? {
        guard let endpoint = endpoint as? EntityEndpoint else { return nil }

        // Построение пути в зависимости от типа ресурса
        var path = ""
        switch endpoint {
        case .events:
            path = "/api/v1/events"
        case .meets:
            path = "/api/v1/meets"
        case .faculties:
            path = "/api/v1/faculties"
        case .communities:
            path = "/api/v1/communities"
        case .eventDetail(let id):
            path = "/api/v1/events/\(id)"
        case .meetDetail(let id):
            path = "/api/v1/meets/\(id)"
        case .facultyDetail(let id):
            path = "/api/v1/faculties/\(id)"
        case .communityDetail(let id):
            path = "/api/v1/communities/\(id)"
        }

        // Генерация URL с параметрами
        var components = URLComponents(string: baseURL + path)
        if let parameters = parameters {
            components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        return components?.url
    }
}
