//
//  CharactersViewModelSpec.swift
//  Rick n Morty CharactersTests
//
//  Created by Sylvan Ash on 04/12/2024.
//

import Foundation
import Quick
import Nimble
@testable import Rick_n_Morty_Characters

final class CharactersViewModelSpec: QuickSpec {
    override class func spec() {
        var sut: CharactersViewModel!
        var service: MockCharacterService!

        beforeEach {
            service = MockCharacterService()
            sut = CharactersViewModel(service: service)
        }

        describe("fetchCharacters") {
            //
        }

        describe("filterCharacters") {
            //
        }

        describe("loadMore") {
            //
        }
    }
}
