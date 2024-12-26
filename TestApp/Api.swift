//
//  Api.swift
//  TestApp
//
//  Created by Kate on 26.12.2024.
//

import Foundation

// Структура для данных, полученных из API
struct Post: Decodable {
    let id: Int
    let title: String
    let content: String
}

// Класс для работы с API
class APIClient {
    let baseURL = URL(string: "https://example.com/api/v1/")!

    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let endpoint = baseURL.appendingPathComponent("posts")
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        
        // Добавляем токен авторизации, если требуется
        request.addValue("Bearer YOUR_ACCESS_TOKEN", forHTTPHeaderField: "Authorization")
        
        // Создаем задачу URLSession
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "DataError", code: -1, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            do {
                // Декодируем JSON
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
