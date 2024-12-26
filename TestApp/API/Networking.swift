import Foundation

protocol NetworkingLogic {
    typealias Response = ((_ response: Result<Networking.ServerResponse, Networking.Error>) -> Void)
    
    func execute(request: Request, completion: @escaping Response)
}

enum Networking {
    struct ServerResponse {
        var data: Data?
        var response: URLResponse?
    }
    
    enum Error: Swift.Error {
        case emptyData
        case invalidRequest
        case decodingError
        case serverError(statusCode: Int)
    }
}

final class BaseURLNetworking: NetworkingLogic {
    var baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func execute(request: Request, completion: @escaping Response) {
        guard let urlRequest = convert(request) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 500)))
                return
            }

            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            
            completion(.success(.init(data: data, response: response)))
        }
        
        task.resume()
    }

    // MARK: - Convert Request to URLRequest
    private func convert(_ request: Request) -> URLRequest? {
        guard let url = generateDestinationURL(for: request) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = request.endpoint.headers
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        urlRequest.timeoutInterval = request.timeout

        return urlRequest
    }

    // MARK: - Generate Destination URL
    private func generateDestinationURL(for request: Request) -> URL? {
        guard
            let url = URL(string: baseURL),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
            return nil
        }

        components.path += request.endpoint.compositePath // Используем compositePath
        
        // Добавляем параметры запроса
        if let parameters = request.endpoint.parameters {
            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        return components.url
    }
}
