import Foundation

/// Простая URLSession-реализация NetworkingLogic
public final class BaseURLNetworking: NetworkingLogic {
    private let baseURL: URL

    /// - Parameter baseURL: полный базовый URL, например "http://localhost:3000/api/v1"
    public init(baseURL: String) {
        guard let url = URL(string: baseURL) else {
            fatalError("Bad base URL: \(baseURL)")
        }
        self.baseURL = url
    }

    public func execute(
        request: Request,
        completion: @escaping (Result<ServerResponse, NetworkError>) -> Void
    ) {
        // 1) Собираем URL
        // новый вариант — убираем ведущий “/” из compositePath
        let relativePath = request.endpoint.compositePath.hasPrefix("/")
            ? String(request.endpoint.compositePath.dropFirst())
            : request.endpoint.compositePath
        guard var comps = URLComponents(
            url: baseURL.appendingPathComponent(relativePath),
            resolvingAgainstBaseURL: false)

        else {
            return completion(.failure(.invalidRequest))
        }
        if let params = request.endpoint.parameters {
            comps.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let url = comps.url else {
            return completion(.failure(.invalidRequest))
        }

        // 2) Готовим URLRequest
        var urlReq = URLRequest(url: url, timeoutInterval: request.timeout)
        urlReq.httpMethod = request.method.rawValue
        urlReq.httpBody   = request.body
        // Берём уже окончательные headers из Request
        request.headers.forEach { urlReq.setValue($0.value, forHTTPHeaderField: $0.key) }

        // 3) Запускаем
        URLSession.shared.dataTask(with: urlReq) { data, response, _ in
            if let http = response as? HTTPURLResponse,
               !(200..<300).contains(http.statusCode) {
                return completion(.failure(.serverError(statusCode: http.statusCode)))
            }
            guard let data = data else {
                return completion(.failure(.emptyData))
            }
            completion(.success(ServerResponse(data: data, response: response)))
        }
        .resume()
    }
}
