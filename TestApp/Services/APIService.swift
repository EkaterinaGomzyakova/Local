//
//  APIService.swift
//  TestApp
//
//  Created by Kate on 26.12.2024.
//

import Foundation

enum APIServiceError: Error {
    /// Сервер вернул пустой ответ
    case emptyData
    /// Неизвестная ошибка
    case unknown
}

/// Сервис для работы со всеми основными ресурсами API
final class APIService {
    private let worker: NetworkingLogic
    private let decoder = JSONDecoder()

    init(worker: NetworkingLogic = BaseURLNetworking(baseURL: "http://localhost:3000/api/v1")) {
        self.worker = worker
        // decoder.dateDecodingStrategy = .iso8601
    }

    /// Получение списка событий
    func fetchEvents(
        page: Int,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        let endpoint = EntityEndpoint.events(page: page)
        let request  = Request(endpoint: endpoint)
        worker.execute(request: request) { result in
            switch result {
            case .failure(let netErr):
                completion(.failure(netErr))
            case .success(let serverResp):
                guard let data = serverResp.data else {
                    completion(.failure(APIServiceError.emptyData))
                    return
                }
                do {
                    let events = try self.decoder.decode([Event].self, from: data)
                    completion(.success(events))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }

    /// Получение списка встреч
    func fetchMeets(
        page: Int,
        userId: Int? = nil,
        completion: @escaping (Result<[Meet], Error>) -> Void
    ) {
        let endpoint = EntityEndpoint.meets(page: page, userId: userId)
        let request  = Request(endpoint: endpoint)
        worker.execute(request: request) { result in
            switch result {
            case .failure(let netErr):
                completion(.failure(netErr))
            case .success(let serverResp):
                guard let data = serverResp.data else {
                    completion(.failure(APIServiceError.emptyData))
                    return
                }
                do {
                    let meets = try self.decoder.decode([Meet].self, from: data)
                    completion(.success(meets))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }

    /// Получение списка факультетов
    func fetchFaculties(
        page: Int,
        completion: @escaping (Result<[Faculty], Error>) -> Void
    ) {
        let endpoint = EntityEndpoint.faculties(page: page)
        let request  = Request(endpoint: endpoint)
        worker.execute(request: request) { result in
            switch result {
            case .failure(let netErr):
                completion(.failure(netErr))
            case .success(let serverResp):
                guard let data = serverResp.data else {
                    completion(.failure(APIServiceError.emptyData))
                    return
                }
                do {
                    let faculties = try self.decoder.decode([Faculty].self, from: data)
                    completion(.success(faculties))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }

    /// Получение списка сообществ
    func fetchCommunities(
        page: Int,
        completion: @escaping (Result<[Community], Error>) -> Void
    ) {
        let endpoint = EntityEndpoint.communities(page: page)
        let request  = Request(endpoint: endpoint)
        worker.execute(request: request) { result in
            switch result {
            case .failure(let netErr):
                completion(.failure(netErr))
            case .success(let serverResp):
                guard let data = serverResp.data else {
                    completion(.failure(APIServiceError.emptyData))
                    return
                }
                do {
                    let communities = try self.decoder.decode([Community].self, from: data)
                    completion(.success(communities))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}

