//
//  CharactersViewModel.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 03/12/2024.
//

import Foundation
import Combine

@MainActor
final class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let service: CharacterService
    private var allCharacters: [Character] = []
    private var currentPage = 1
    private var canLoadMore = true
    private var filter: Character.Status?

    init(service: CharacterService) {
        self.service = service
    }

    func fetchCharacters() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        let results = await service.fetchCharacters(page: currentPage)

        switch results {
        case .success(let response):
            allCharacters.append(contentsOf: response.results)
            filterCharacters(withStatus: filter)

            if response.info.next == nil {
                canLoadMore = false
            }
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }

        isLoading = false
    }

    func filterCharacters(withStatus status: Character.Status?) {
        self.filter = status

        if let status = status {
            characters = allCharacters.filter { $0.status == status }
        } else {
            characters = allCharacters
        }
    }

    func loadMore() async {
        guard canLoadMore else { return }
        currentPage += 1
        await fetchCharacters()
    }
}
