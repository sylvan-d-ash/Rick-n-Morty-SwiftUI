//
//  DataService.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 03/12/2024.
//

import Foundation

protocol CharacterService {
    func fetchCharacters() async throws -> [Character]
}

private struct CharactersAPIResponse: Decodable {
    let results: [Character]
}

class DataService: CharacterService {
    private let baseUrl = "https://rickandmortyapi.com/api/character"

    func fetchCharacters() async throws -> [Character] {
        guard let url = URL(string: baseUrl) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(CharactersAPIResponse.self, from: data)
        return response.results
    }
}
