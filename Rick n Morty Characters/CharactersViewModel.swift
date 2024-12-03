//
//  CharactersViewModel.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 03/12/2024.
//

import Foundation
import Combine

@MainActor
class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let service: CharacterService

    init(service: CharacterService) {
        self.service = service
    }

    func fetchCharacters() async {
        isLoading = true
        errorMessage = nil

        do {
            let results = try await service.fetchCharacters()
            characters = results
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
