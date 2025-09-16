//
//  GiveawaysViewModel.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//


import SwiftUI
import Combine

@MainActor
class GiveawaysViewModel: ObservableObject {
    @Published var giveaways: [Giveaway] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let service = NetworkService()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Async/Await
    func loadGiveawaysAsync() {
        Task {
            isLoading = true
            errorMessage = nil
            do {
                let result = try await service.fetchGiveawaysAsync()
                giveaways = result
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }

    // MARK: - Combine
    func loadGiveaways() {
        isLoading = true
        errorMessage = nil
        service.fetchGiveaways()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            } receiveValue: { giveaways in
                self.giveaways = giveaways
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
}
