//
//  EventService.swift
//  TestApp
//
//  Сервис для работы с событиями: fetch / create
//

import Foundation

/// Все ошибки, которые может вернуть EventService
public enum EventServiceError: Error {
    case unauthorized
    case emptyData
    case decodingError(Error)
    case networkError(NetworkError)
    case serverError(statusCode: Int)
}

/// Сервис для загрузки/создания событий
public final class EventService {
    public static let shared = EventService()

    /// Наш сетевой слой на базе BaseURLNetworking
    private let networking = BaseURLNetworking(baseURL: "http://localhost:3000/api/v1")
    private let decoder    = JSONDecoder()

    private init() {
        // Если сервер отдаёт даты в ISO8601
        decoder.dateDecodingStrategy = .iso8601
    }

    // MARK: — Загрузка списка событий
    func fetchEvents(
        page: Int,
        completion: @escaping (Result<[Event], EventServiceError>) -> Void
    ) {
        let endpoint = EntityEndpoint.events(page: page)
        let request  = Request(endpoint: endpoint)

        networking.execute(request: request) { result in
            switch result {
            case .failure(let netErr):
                completion(.failure(.networkError(netErr)))

            case .success(let response):
                guard let data = response.data else {
                    return completion(.failure(.emptyData))
                }
                do {
                    let events = try self.decoder.decode([Event].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(events))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError(error)))
                    }
                }
            }
        }
    }

    // MARK: — Создание нового события
    public func createEvent(
        title: String,
        description: String,
        communityId: Int,
        isPublic: Bool,
        completion: @escaping (Result<Void, EventServiceError>) -> Void
    ) {
        // 1) Проверяем авторизацию
        guard let authHeader = AuthService.shared.authorizationHeader() else {
            return completion(.failure(.unauthorized))
        }

        // 2) Собираем тело запроса
        let payload: [String: Any] = [
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

        // 3) Формируем endpoint и Request с нужными заголовками
        let endpoint = EntityEndpoint.events(page: 1)
        let request = Request(
            endpoint: endpoint,
            method: .post,
            timeout: 30,
            body: body,
            headers: [
                "Authorization": authHeader
            ]
        )

        // 4) Выполняем запрос
        networking.execute(request: request) { result in
            switch result {
            case .failure(let netErr):
                completion(.failure(.networkError(netErr)))
            case .success(let response):
                if let http = response.response as? HTTPURLResponse,
                   !(200..<300).contains(http.statusCode) {
                    completion(.failure(.serverError(statusCode: http.statusCode)))
                } else {
                    DispatchQueue.main.async {
                        completion(.success(()))
                    }
                }
            }
        }
    }
}
