//
//  APIClient.swift
//  TestApp
//
//  Created by Kate on 26.12.2024.
//

import Foundation

/// Общие ошибки сети
enum APIError: Error {
    case badURL
    case noData
    case decodingError(Error)
    case serverError(status: Int)
}

/// Модель «Post»
struct Post: Decodable, Identifiable {
    let id: Int
    let title: String
    let content: String
}

/// Клиент для работы с API
final class APIClient {
    static let shared = APIClient()
    private let baseURL = URL(string: "https://example.com/api/v1/")!
    private var token: String?

    private init() {}

    /// Токен при логине
    func setToken(_ token: String) {
        self.token = token
    }

    func get<T: Decodable>(
        _ path: String,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard let url = URL(string: path, relativeTo: baseURL) else {
            return completion(.failure(.badURL))
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTask(with: request) { data, resp, error in
            if let error = error {
                return completion(.failure(.decodingError(error)))
            }
            guard let http = resp as? HTTPURLResponse else {
                return completion(.failure(.serverError(status: -1)))
            }
            guard (200...299).contains(http.statusCode) else {
                return completion(.failure(.serverError(status: http.statusCode)))
            }
            guard let data = data else {
                return completion(.failure(.noData))
            }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async { completion(.success(decoded)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(.decodingError(error))) }
            }
        }.resume()
    }

    /// Конкретный метод «posts»
    func fetchPosts(completion: @escaping (Result<[Post], APIError>) -> Void) {
        get("posts", completion: completion)
    }
}
