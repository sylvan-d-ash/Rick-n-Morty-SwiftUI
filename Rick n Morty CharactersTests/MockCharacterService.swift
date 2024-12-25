//
//  MockCharacterService.swift
//  Rick n Morty CharactersTests
//
//  Created by Sylvan Ash on 04/12/2024.
//

import Foundation
@testable import Rick_n_Morty_Characters

final class MockCharacterService: CharacterServiceProtocol {
    var fetchCharactersResult: Result<CharactersResponse, Error>?
    private(set) var page: Int?

    func fetchCharacters(page: Int) async -> Result<CharactersResponse, Error> {
        self.page = page
        return fetchCharactersResult!
    }
}
