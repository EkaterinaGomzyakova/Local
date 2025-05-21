// Networking/Request.swift

import Foundation

public enum HTTPMethod: String {
    case get, post, put, delete, patch, options
}

public struct Request {
    public let endpoint: Endpoint
    public let method: HTTPMethod
    public let parameters: [String: String]?
    public let timeout: TimeInterval
    public let body: Data?
    public let headers: [String: String]

    public init(
        endpoint: Endpoint,
        method: HTTPMethod = .get,
        parameters: [String:String]? = nil,
        timeout: TimeInterval = 60,
        body: Data? = nil,
        headers: [String:String] = [:]
    ) {
        self.endpoint   = endpoint
        self.method     = method
        self.timeout    = timeout
        self.body       = body
        // merge endpoint.parameters + passed parameters
        var mergedParams = endpoint.parameters ?? [:]
        parameters?.forEach { mergedParams[$0.key] = $0.value }
        self.parameters = mergedParams.isEmpty ? nil : mergedParams
        // merge endpoint.headers + passed headers
        var mergedHeaders = endpoint.headers
        headers.forEach { mergedHeaders[$0.key] = $0.value }
        self.headers = mergedHeaders
    }
}
