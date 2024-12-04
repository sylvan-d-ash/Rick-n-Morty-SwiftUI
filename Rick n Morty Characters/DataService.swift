//
//  DataService.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 03/12/2024.
//

import Foundation

protocol CharacterService {
    func fetchCharacters(page: Int) async -> Result<CharactersResponse, Error>
}

class DataService: CharacterService {
    private let baseUrl = "https://rickandmortyapi.com/api/character"

    func fetchCharacters(page: Int) async -> Result<CharactersResponse, Error> {
        guard let url = URL(string: baseUrl + "?page=\(page)") else {
            return .failure(URLError(.badURL))
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(CharactersResponse.self, from: data)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
