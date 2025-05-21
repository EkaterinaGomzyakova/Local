// AuthService.swift
// TestApp
//
// Сервис для авторизации: логин + хранение токена
//

import Foundation

/// Ошибки аутентификации
public enum AuthError: Error {
    case invalidURL
    case serverError(statusCode: Int)
    case noData
    case decodingError
    case unauthorized
}

/// Специальный Endpoint для логина
private enum AuthEndpoint: Endpoint {
    case signIn
    
    /// относительный путь (без базового `/api/v1`)
    var compositePath: String {
        switch self {
        case .signIn:
            return "/users/sign_in"
        }
    }
    
    /// базовые HTTP-заголовки
    var headers: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept":       "application/json"
        ]
    }
    
    /// GET-параметры (не нужны)
    var parameters: [String : String]? { nil }
}

/// Сервис для авторизации
public final class AuthService {
    public static let shared = AuthService()
    
    /// Сетевой слой на базе URLSession
    private let networking = BaseURLNetworking(baseURL: "http://localhost:3000/api/v1")
    
    private init() {}
    
    /// Последний токен вида “Bearer …”
    private(set) var token: String?
    
    /// Выполняет вход, сохраняет токен и возвращает его в колбэке
    public func login(
        email: String,
        password: String,
        completion: @escaping (Result<String, AuthError>) -> Void
    ) {
        // 1) Формируем тело запроса
        let payload: [String:Any] = [
            "user": [
                "email": email,
                "password": password
            ]
        ]
        guard let body = try? JSONSerialization.data(withJSONObject: payload) else {
            return completion(.failure(.decodingError))
        }
        
        // 2) Конструируем Request
        let req = Request(
            endpoint: AuthEndpoint.signIn,
            method: HTTPMethod.post,
            body: body
        )
        
        // 3) Отправляем
        networking.execute(request: req) { result in
            switch result {
            case .failure(let netErr):
                if case .serverError(let code) = netErr {
                    completion(.failure(.serverError(statusCode: code)))
                } else {
                    completion(.failure(.noData))
                }
                
            case .success(let serverResp):
                // проверяем HTTP-код и заголовок Authorization
                guard
                    let http = serverResp.response as? HTTPURLResponse,
                    http.statusCode == 200,
                    let authHeader = http.allHeaderFields["Authorization"] as? String
                else {
                    return completion(.failure(.unauthorized))
                }
                
                // убираем префикс и сохраняем токен
                let raw = authHeader.replacingOccurrences(of: "Bearer ", with: "")
                self.token = raw
                DispatchQueue.main.async {
                    completion(.success(raw))
                }
            }
        }
    }
    
    /// Хелпер для добавления заголовка Authorization к другим запросам
    public func authorizationHeader() -> String? {
        guard let t = token else { return nil }
        return "Bearer \(t)"
    }
}
