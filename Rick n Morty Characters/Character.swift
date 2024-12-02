//
//  Character.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 02/12/2024.
//

import Foundation

struct Character: Decodable, Identifiable {
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
    let location: Location
}
