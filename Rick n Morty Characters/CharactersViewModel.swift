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

    init(service: CharacterService) {
        self.service = service
    }

    func fetchCharacters() async {
        isLoading = true
        errorMessage = nil

        do {
            let results = try await service.fetchCharacters()
            allCharacters = results
            characters = results
        } catch {
            errorMessage = error.localizedDescription
            print("Error: \(error.localizedDescription)")
        }

        isLoading = false
    }

    func filterCharacters(withStatus status: Character.Status?) {
        if let status = status {
            characters = allCharacters.filter { $0.status == status }
        } else {
            characters = allCharacters
        }
    }
}
