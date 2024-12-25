//
//  CharacterService.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 25/12/2024.
//

import Foundation

enum CharactersEndpoint: APIEndpoint {
    case getCharacters(page: Int)

    var path: String {
        switch self {
        case .getCharacters: return "/character"
        }
    }

    var parameters: [String : Any]? {
        switch self {
        case .getCharacters(let page): return ["page": page]
        }
    }
}

protocol CharacterServiceProtocol {
    func fetchCharacters(page: Int) async -> Result<CharactersResponse, Error>
}

class CharacterService: CharacterServiceProtocol {
    let apiClient: APIClient

    init(apiClient: APIClient = URLSessionAPIClient()) {
        self.apiClient = apiClient
    }

    func fetchCharacters(page: Int) async -> Result<CharactersResponse, Error> {
        let endpoint = CharactersEndpoint.getCharacters(page: page)
        return await apiClient.request(endpoint)
    }
}
