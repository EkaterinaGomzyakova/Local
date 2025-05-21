//
//  AuthService.swift
//  TestApp
//
//  Created by You on 05.21.2025.
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

/// Специальный Endpoint для login
private enum AuthEndpoint: Endpoint {
  case signIn
  
  var compositePath: String {
    switch self {
    case .signIn:
      return "/users/sign_in"
    }
  }
  
  var headers: [String : String] {
    [
      "Content-Type": "application/json",
      "Accept":       "application/json"
    ]
  }
  
  var parameters: [String : String]? { nil }
}

/// Сервис для авторизации: логин + хранение токена
public final class AuthService {
  public static let shared = AuthService()
  private let networking = BaseURLNetworking(baseURL: "http://localhost:3000/api/v1")

  private init() {}
  
  /// Токен в формате “Bearer …”
  private(set) var token: String?
  
  /// Выполняет вход и сохраняет токен
  public func login(
    email: String,
    password: String,
    completion: @escaping (Result<String, AuthError>) -> Void
  ) {
    // 1) Собираем body
    let payload: [String:Any] = [
      "user": [
        "email": email,
        "password": password
      ]
    ]
    guard let body = try? JSONSerialization.data(withJSONObject: payload) else {
      return completion(.failure(.decodingError))
    }
    
    // 2) Формируем Request
    let req = Request(
      endpoint: AuthEndpoint.signIn,
      method: .post,
      parameters: nil,
      timeout: 30,
      body: body
    )
    
    // 3) Отправляем через BaseURLNetworking
    networking.execute(request: req) { result in
      switch result {
      case .failure(let netErr):
        // если сервер вернул не-2xx
        if case .serverError(let code) = netErr {
          completion(.failure(.serverError(statusCode: code)))
        } else {
          completion(.failure(.noData))
        }
        
      case .success(let serverResp):
        // HTTPURLResponse + header “Authorization”
        guard
          let http = serverResp.response as? HTTPURLResponse,
          http.statusCode == 200,
          let authHeader = http.allHeaderFields["Authorization"] as? String
        else {
          return completion(.failure(.unauthorized))
        }
        
        // Убираем “Bearer ”
        let raw = authHeader.replacingOccurrences(of: "Bearer ", with: "")
        self.token = raw
        DispatchQueue.main.async {
          completion(.success(raw))
        }
      }
    }
  }
  
  /// Хэлпер для получения заголовка авторизации
  public func authorizationHeader() -> String? {
    guard let t = token else { return nil }
    return "Bearer \(t)"
  }
}
