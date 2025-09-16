//
//  NetworkService.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import Moya
import Combine
import Foundation

class NetworkService: ObservableObject {
    private let provider = MoyaProvider<GPService>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Combine
    
    func fetchGiveaways() -> AnyPublisher<[Giveaway], Error> {
        return Future { promise in
            self.provider.request(.getGiveaways) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let giveaways = try decoder.decode([Giveaway].self, from: response.data)
                        promise(.success(giveaways))
                    } catch {
                        promise(.failure(error))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Async/Await
    
    func fetchGiveawaysAsync() async throws -> [Giveaway] {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getGiveaways) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let giveaways = try decoder.decode([Giveaway].self, from: response.data)
                        continuation.resume(returning: giveaways)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func fetchGiveaway(id: Int) async throws -> Giveaway {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getGiveaway(id: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let giveaway = try decoder.decode(Giveaway.self, from: response.data)
                        continuation.resume(returning: giveaway)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
