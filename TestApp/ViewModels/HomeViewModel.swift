// HomeViewModel.swift

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    // MARK: — опубликованные данные
    @Published var events: [Event] = []
    @Published var meets:  [Meet]  = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // Берём единственный экземпляр сервиса
    private let api = APIService.shared

    func loadAll() {
        isLoading = true
        errorMessage = nil

        // 1) Сначала – события
        api.fetchEvents(page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let evs):
                self.events = evs
            case .failure(let err):
                self.errorMessage = "Events error: \(err.localizedDescription)"
            }

            // 2) Затем – встречи
            self.api.fetchMeets(page: 1) { [weak self] meetResult in
                guard let self = self else { return }
                switch meetResult {
                case .success(let ms):
                    self.meets = ms
                case .failure(let err2):
                    self.errorMessage = "Meets error: \(err2.localizedDescription)"
                }
                // 3) Готово, сняли индикатор загрузки
                self.isLoading = false
            }
        }
    }
}
