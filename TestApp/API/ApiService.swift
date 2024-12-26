import Foundation

final class ApiService {
    let worker = BaseURLNetworking(baseURL: "http://localhost:3000")
    let decoder = JSONDecoder()
    
    // Функция для получения событий
    func fetchEvents(
        page: Int,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        let endpoint = EntityEndpoint.events(page: page)
        let request = Request(endpoint: endpoint)
        
        worker.execute(request: request) { response in
            switch response {
            case .success(let serverResponse):
                guard let data = serverResponse.data else {
                    completion(.failure(Networking.Error.emptyData))
                    return
                }
                
                do {
                    let events = try self.decoder.decode([Event].self, from: data)
                    completion(.success(events))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Функция для получения встреч
    func fetchMeets(
        page: Int,
        userId: Int? = nil, // Добавляем параметр userId с дефолтным значением nil
        completion: @escaping (Result<[Meet], Error>) -> Void
    ) {
        let endpoint = EntityEndpoint.meets(page: page, userId: userId) // Передаем userId
        let request = Request(endpoint: endpoint)
        
        worker.execute(request: request) { response in
            switch response {
            case .success(let serverResponse):
                guard let data = serverResponse.data else {
                    completion(.failure(Networking.Error.emptyData))
                    return
                }
                
                do {
                    let meets = try self.decoder.decode([Meet].self, from: data)
                    completion(.success(meets))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Функция для получения факультетов
    func fetchFaculties(
        page: Int,
        completion: @escaping (Result<[Faculty], Error>) -> Void
    ) {
        let endpoint = EntityEndpoint.faculties(page: page)
        let request = Request(endpoint: endpoint)
        
        worker.execute(request: request) { response in
            switch response {
            case .success(let serverResponse):
                guard let data = serverResponse.data else {
                    completion(.failure(Networking.Error.emptyData))
                    return
                }
                
                do {
                    let faculties = try self.decoder.decode([Faculty].self, from: data)
                    completion(.success(faculties))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Функция для получения сообществ
    func fetchCommunities(
        page: Int,
        completion: @escaping (Result<[Community], Error>) -> Void
    ) {
        let endpoint = EntityEndpoint.communities(page: page)
        let request = Request(endpoint: endpoint)
        
        worker.execute(request: request) { response in
            switch response {
            case .success(let serverResponse):
                guard let data = serverResponse.data else {
                    completion(.failure(Networking.Error.emptyData))
                    return
                }
                
                do {
                    let communities = try self.decoder.decode([Community].self, from: data)
                    completion(.success(communities))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
