//
//  MockCharacterService.swift
//  Rick n Morty CharactersTests
//
//  Created by Sylvan Ash on 04/12/2024.
//

import Foundation
@testable import Rick_n_Morty_Characters

final class MockCharacterService: CharacterService {
    var fetchCharactersResult: Result<CharactersResponse, Error>?

    func fetchCharacters(page: Int) async -> Result<CharactersResponse, Error> {
        return fetchCharactersResult ?? .failure(URLError(.cancelled))
    }
}
