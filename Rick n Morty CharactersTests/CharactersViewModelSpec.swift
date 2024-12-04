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

final class CharactersViewModelSpec: AsyncSpec {
    override class func spec() {
        var sut: CharactersViewModel!
        var service: MockCharacterService!

        beforeEach {
            service = MockCharacterService()
            sut = await CharactersViewModel(service: service)
        }

        describe("fetchCharacters") {
            context("when the API call succeeds") {
                it("updates characters and stops loading") { @MainActor in
                    // given
                    let characters = [
                        Character(id: 1, name: "Rick", species: "Human", image: "rick.png", status: .alive, gender: .male, location: "Earth"),
                        Character(id: 2, name: "Morty", species: "Human", image: "morty.png", status: .alive, gender: .male, location: "Earth"),
                        Character(id: 3, name: "Zephyr", species: "Elf", image: "zephyr.png", status: .dead, gender: .female, location: "Pangea"),
                    ]
                    let response = CharactersResponse(results: characters, info: PaginationInfo(next: nil))
                    service.fetchCharactersResult = .success(response)

                    // when
                    await sut.fetchCharacters()

                    // then
                    expect(sut.characters).to(equal(characters))
                    expect(sut.isLoading).to(beFalse())
                    expect(sut.errorMessage).to(beNil())
                }
            }
        }
    }
}
