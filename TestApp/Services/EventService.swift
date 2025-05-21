import Foundation

/// Ошибки, связанные с событиями
enum EventError: Error {
  case invalidURL
  case unauthorized
  case serverError(statusCode: Int)
  case noData
  case decodingError(Error)
}

/// Сервис для работы с событиями: fetch / create / update / delete
final class EventService {
  static let shared = EventService()
  private let networking = BaseURLNetworking(baseURL: "http://localhost:3000/api/v1")
  private let decoder = JSONDecoder()
  
  private init() {
    decoder.dateDecodingStrategy = .iso8601
  }
  
  /// Загрузить список событий
  func fetchEvents(
    page: Int,
    completion: @escaping (Result<[Event], EventError>) -> Void
  ) {
    let endpoint = EntityEndpoint.events(page: page)
    let req = Request(endpoint: endpoint, method: .get)
    
    networking.execute(request: req) { result in
      switch result {
      case .failure(let netErr):
        if case .serverError(let code) = netErr {
          completion(.failure(.serverError(statusCode: code)))
        } else {
          completion(.failure(.noData))
        }
        
      case .success(let serverResp):
        guard let data = serverResp.data else {
          return completion(.failure(.noData))
        }
        do {
          let events = try self.decoder.decode([Event].self, from: data)
          DispatchQueue.main.async { completion(.success(events)) }
        } catch {
          DispatchQueue.main.async { completion(.failure(.decodingError(error))) }
        }
      }
    }
  }
  
  /// Создать новое событие
  func createEvent(
    title: String,
    description: String,
    communityId: Int,
    isPublic: Bool,
    completion: @escaping (Result<Event, EventError>) -> Void
  ) {
    // Проверяем, что пользователь залогинен
    guard let authHeader = AuthService.shared.authorizationHeader() else {
      return completion(.failure(.unauthorized))
    }
    
    // Собираем тело запроса
    let payload: [String:Any] = [
      "event": [
        "title": title,
        "description": description,
        "community_id": communityId,
        "public": isPublic
      ]
    ]
    guard let body = try? JSONSerialization.data(withJSONObject: payload) else {
      return completion(.failure(.decodingError(NSError())))
    }
    
    // Делаем Request
    var req = Request(endpoint: EntityEndpoint.events(page: 1),
                      method: .post,
                      parameters: nil,
                      timeout: 30,
                      body: body)
    // По-быстрому приклеиваем заголовок авторизации:
    // (лучше добавить возможность передавать headers в Request)
    var urlRequest = URLRequest(url: URL(string: "http://localhost:3000/api/v1/events")!)
    urlRequest.httpMethod = HTTPMethod.post.rawValue
    EntityEndpoint.events(page: 1).headers.forEach {
      urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
    }
    urlRequest.setValue(authHeader, forHTTPHeaderField: "Authorization")
    urlRequest.httpBody = body
    
    // Выполняем напрямую через URLSession
    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      if let http = response as? HTTPURLResponse,
         !(200..<300).contains(http.statusCode) {
        return completion(.failure(.serverError(statusCode: http.statusCode)))
      }
      guard let data = data else {
        return completion(.failure(.noData))
      }
      do {
        let event = try self.decoder.decode(Event.self, from: data)
        DispatchQueue.main.async { completion(.success(event)) }
      } catch {
        DispatchQueue.main.async { completion(.failure(.decodingError(error))) }
      }
    }
    .resume()
  }
}

