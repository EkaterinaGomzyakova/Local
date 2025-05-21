//
//  BaseURLNetworking.swift
//  TestApp
//
//  Created by You on 05.21.2025.
//

import Foundation

/// Общий протокол для сетевого слоя
public protocol NetworkingLogic {
    /// В случае успеха даём серверный ответ (Data + URLResponse)
    typealias Response = (Result<ServerResponse, NetworkingError>) -> Void
    
    /// Выполнить запрос и вернуть либо данные, либо ошибку
    func execute(request: Request, completion: @escaping Response)
}

/// Обёртка результата URLSession
public struct ServerResponse {
    public let data: Data?
    public let response: URLResponse?
}

/// Возможные ошибки на уровне сети
public enum NetworkingError: Error {
    case invalidRequest      // не смогли сконвертировать Request → URLRequest
    case emptyData           // сервер вернул без тела
    case serverError(statusCode: Int) // ответ не 2xx
}

/// Конкретная реализация сетевого слоя на URLSession
public final class BaseURLNetworking: NetworkingLogic {
    /// Полный базовый URL, включая версию API
    private let baseURL: URL

    /// Инициализируем один раз при старте
    /// - parameter baseURL: например "http://localhost:3000/api/v1"
    public init(baseURL: String) {
        guard let url = URL(string: baseURL) else {
            fatalError("❌ BaseURLNetworking: неверный базовый URL «\(baseURL)»")
        }
        self.baseURL = url
    }
    
    /// Собираем URLRequest, выполняем DataTask и возвращаем ServerResponse
    public func execute(request: Request, completion: @escaping Response) {
        // 1) Конвертим Request → URLRequest
        guard let urlRequest = makeURLRequest(from: request) else {
            completion(.failure(.invalidRequest))
            return
        }

        // 2) Запускаем задачу
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // 2a) Сетевая ошибка
            if let http = response as? HTTPURLResponse,
               !(200..<300).contains(http.statusCode) {
                return completion(.failure(.serverError(statusCode: http.statusCode)))
            }
            // 2b) Пустые данные
            guard let data = data else {
                return completion(.failure(.emptyData))
            }
            // 2c) ОК
            completion(.success(
                ServerResponse(data: data, response: response)
            ))
        }
        task.resume()
    }
    
    // MARK: - Вспомогательные
    
    /// Делаем URLRequest из нашей обёртки
    private func makeURLRequest(from request: Request) -> URLRequest? {
        // 1) Собираем абсолютный URL: baseURL + endpoint.compositePath + queryItems
        guard var components = URLComponents(
                url: baseURL.appendingPathComponent(request.endpoint.compositePath),
                resolvingAgainstBaseURL: false
        ) else {
            return nil
        }
        // 1a) query-параметры, если есть
        if let params = request.endpoint.parameters {
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let finalURL = components.url else { return nil }
        
        // 2) URLRequest
        var urlReq = URLRequest(url: finalURL)
        urlReq.httpMethod = request.method.rawValue
        // 2a) заголовки из endpoint
        request.endpoint.headers.forEach { urlReq.setValue($0.value, forHTTPHeaderField: $0.key) }
        // 2b) тело, если есть
        urlReq.httpBody = request.body
        // 2c) таймаут
        urlReq.timeoutInterval = request.timeout
        
        return urlReq
    }
}

