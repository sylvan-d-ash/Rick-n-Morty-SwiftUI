//
//  Character.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 02/12/2024.
//

import Foundation

struct Character: Decodable, Identifiable, Equatable {
    enum Gender: String, Decodable {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown = "unknown"
    }

    enum Status: String, Decodable, CaseIterable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "Unknown"
    }

    struct Location: Decodable {
        let name: String
    }

    let id: Int
    let name: String
    let species: String
    let image: String
    let status: Status
    let gender: Gender
    let location: String
}

extension Character {
    private enum CodingKeys: String, CodingKey {
        case id, name, species, image, status, gender, location
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        species = try container.decode(String.self, forKey: .species)
        image = try container.decode(String.self, forKey: .image)

        let _status = try container.decode(String.self, forKey: .status)
        status = Status(rawValue: _status) ?? .unknown

        let _gender = try container.decode(String.self, forKey: .gender)
        gender = Gender(rawValue: _gender) ?? .unknown

        let _location = try container.decode(Location.self, forKey: .location)
        location = _location.name
    }
}

struct CharactersResponse: Decodable {
    let results: [Character]
    let info: PaginationInfo
}

struct PaginationInfo: Decodable {
    let next: String?
}
