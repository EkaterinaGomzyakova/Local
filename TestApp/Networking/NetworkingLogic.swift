import Foundation

public struct ServerResponse {
  public let data: Data?
  public let response: URLResponse?
}

public enum NetworkError: Error {
  case invalidRequest
  case emptyData
  case serverError(statusCode: Int)
}

public protocol NetworkingLogic {
  func execute(
    request: Request,
    completion: @escaping (Result<ServerResponse, NetworkError>) -> Void
  )
}

