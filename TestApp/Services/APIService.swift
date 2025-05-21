// Services/APIService.swift

import Foundation

/// Ошибки, которые может вернуть APIService
public enum APIServiceError: Error {
    case emptyData
    case decodingError(Error)
    case networkError(NetworkError)
}

/// Сервис для работы с основными ресурсами API
public final class APIService {
    public static let shared = APIService()
    
    private let networking = BaseURLNetworking(baseURL: "http://localhost:3000/api/v1")
    private let decoder    = JSONDecoder()
    
    private init() {
        // Если сервер отдаёт даты в ISO8601
        decoder.dateDecodingStrategy = .iso8601
    }
    
    // MARK: — События
    func fetchEvents(
        page: Int,
        completion: @escaping (Result<[Event], APIServiceError>) -> Void
    ) {
        let ep  = EntityEndpoint.events(page: page)
        let req = Request(endpoint: ep)
        
        networking.execute(request: req) { result in
            switch result {
            case .failure(let err):
                completion(.failure(.networkError(err)))
                
            case .success(let res):
                guard let data = res.data else {
                    completion(.failure(.emptyData)); return
                }
                do {
                    let list = try self.decoder.decode([Event].self, from: data)
                    DispatchQueue.main.async { completion(.success(list)) }
                } catch {
                    DispatchQueue.main.async { completion(.failure(.decodingError(error))) }
                }
            }
        }
    }
    
    // MARK: — Встречи
    func fetchMeets(
        page: Int,
        userId: Int? = nil,
        completion: @escaping (Result<[Meet], APIServiceError>) -> Void
    ) {
        let ep  = EntityEndpoint.meets(page: page, userId: userId)
        let req = Request(endpoint: ep)
        
        networking.execute(request: req) { result in
            switch result {
            case .failure(let err):
                completion(.failure(.networkError(err)))
                
            case .success(let res):
                guard let data = res.data else {
                    completion(.failure(.emptyData)); return
                }
                do {
                    let list = try self.decoder.decode([Meet].self, from: data)
                    DispatchQueue.main.async { completion(.success(list)) }
                } catch {
                    DispatchQueue.main.async { completion(.failure(.decodingError(error))) }
                }
            }
        }
    }
    
    // MARK: — Факультеты
    func fetchFaculties(
        page: Int,
        completion: @escaping (Result<[Faculty], APIServiceError>) -> Void
    ) {
        let ep  = EntityEndpoint.faculties(page: page)
        let req = Request(endpoint: ep)
        
        networking.execute(request: req) { result in
            switch result {
            case .failure(let err):
                completion(.failure(.networkError(err)))
                
            case .success(let res):
                guard let data = res.data else {
                    completion(.failure(.emptyData)); return
                }
                do {
                    let list = try self.decoder.decode([Faculty].self, from: data)
                    DispatchQueue.main.async { completion(.success(list)) }
                } catch {
                    DispatchQueue.main.async { completion(.failure(.decodingError(error))) }
                }
            }
        }
    }
    
    // MARK: — Сообщества
    func fetchCommunities(
        page: Int,
        completion: @escaping (Result<[Community], APIServiceError>) -> Void
    ) {
        let ep  = EntityEndpoint.communities(page: page)
        let req = Request(endpoint: ep)
        
        networking.execute(request: req) { result in
            switch result {
            case .failure(let err):
                completion(.failure(.networkError(err)))
                
            case .success(let res):
                guard let data = res.data else {
                    completion(.failure(.emptyData)); return
                }
                do {
                    let list = try self.decoder.decode([Community].self, from: data)
                    DispatchQueue.main.async { completion(.success(list)) }
                } catch {
                    DispatchQueue.main.async { completion(.failure(.decodingError(error))) }
                }
            }
        }
    }
}
