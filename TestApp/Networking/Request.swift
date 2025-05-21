//
//  Request.swift
//  TestApp
//
//  Created by Kate on 26.12.2024.
//

import Foundation

/// HTTP-методы
public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
    case patch   = "PATCH"
    case options = "OPTIONS"
}

/// Описание одного сетевого запроса
public struct Request {
    public let endpoint: Endpoint
    public let method: HTTPMethod
    public let parameters: [String: String]?
    public let timeout: TimeInterval
    public let body: Data?

    /// Инициализатор: в качестве параметров можно передать свои дополнительные query-параметры и/или тело
    public init(
        endpoint: Endpoint,
        method: HTTPMethod = .get,
        parameters: [String: String]? = nil,
        timeout: TimeInterval = 60,
        body: Data? = nil
    ) {
        // Сначала забираем параметры из самого endpoint
        var merged = endpoint.parameters ?? [:]
        // Затем «накладываем» пользовательские
        if let params = parameters {
            params.forEach { merged[$0.key] = $0.value }
        }
        self.endpoint   = endpoint
        self.method     = method
        self.parameters = merged.isEmpty ? nil : merged
        self.timeout    = timeout
        self.body       = body
    }
}

