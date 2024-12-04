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
        let testCharacters = [
            Character(id: 1, name: "Rick", species: "Human", image: "rick.png", status: .alive, gender: .male, location: "Earth"),
            Character(id: 2, name: "Morty", species: "Human", image: "morty.png", status: .alive, gender: .male, location: "Earth"),
            Character(id: 3, name: "Zephyr", species: "Elf", image: "zephyr.png", status: .dead, gender: .female, location: "Pangea"),
        ]

        beforeEach {
            service = MockCharacterService()
            sut = await CharactersViewModel(service: service)
        }

        describe("fetchCharacters") {
            context("when the API call succeeds") {
                it("updates characters and stops loading") { @MainActor in
                    // given
                    let response = CharactersResponse(results: testCharacters, info: PaginationInfo(next: nil))
                    service.fetchCharactersResult = .success(response)

                    // when
                    await sut.fetchCharacters()

                    // then
                    expect(sut.characters).to(equal(testCharacters))
                    expect(sut.isLoading).to(beFalse())
                    expect(sut.errorMessage).to(beNil())
                }
            }

            context("when the API call fails") {
                it("sets an error message and stops loading") { @MainActor in
                    // given
                    service.fetchCharactersResult = .failure(NSError(domain: "Test Error", code: -1))

                    // when
                    await sut.fetchCharacters()

                    // then
                    expect(sut.characters).to(beEmpty())
                    expect(sut.isLoading).to(beFalse())
                    expect(sut.errorMessage).to(equal("Failed to fetch characters: The operation couldn’t be completed. (Test Error error -1.)"))
                }
            }
        }

        describe("filterCharacters") {
            it("should filter characters by status") { @MainActor in
                // given
                let response = CharactersResponse(results: testCharacters, info: PaginationInfo(next: nil))
                service.fetchCharactersResult = .success(response)

                await sut.fetchCharacters()

                // filter by 'alive'
                sut.filterCharacters(withStatus: .alive)
                expect(sut.characters.count).to(equal(2))

                // filter by 'dead'
                sut.filterCharacters(withStatus: .dead)
                expect(sut.characters.count).to(equal(1))

                // filter by 'unknown'
                sut.filterCharacters(withStatus: .unknown)
                expect(sut.characters).to(beEmpty())

                // no filter
                sut.filterCharacters(withStatus: nil)
                expect(sut.characters.count).to(equal(3))
            }
        }

        describe("loadMore") {
            context("when there is more content") {
                it("fetches the next page of characters") { @MainActor in
                    // given
                    let response = CharactersResponse(results: testCharacters, info: PaginationInfo(next: "2"))
                    service.fetchCharactersResult = .success(response)
                    await sut.fetchCharacters()

                    expect(service.page).to(equal(1))
                    expect(sut.characters.count).to(equal(3))

                    // when
                    let extraCharacters = [
                        Character(id: 4, name: "Toxic Rick", species: "Humanoid", image: "toxic.png", status: .unknown, gender: .unknown, location: "Mars")
                    ]
                    let newResponse = CharactersResponse(results: extraCharacters, info: PaginationInfo(next: nil))
                    service.fetchCharactersResult = .success(newResponse)
                    await sut.loadMore()

                    // then
                    expect(sut.characters.count).to(equal(4))
                    expect(sut.isLoading).to(beFalse())
                    expect(sut.errorMessage).to(beNil())
                    expect(service.page).to(equal(2))
                }
            }

            context("when there is no more content") {
                it("does not fetch anything") { @MainActor in
                    // given
                    let response = CharactersResponse(results: testCharacters, info: PaginationInfo(next: nil))
                    service.fetchCharactersResult = .success(response)
                    await sut.fetchCharacters()

                    expect(service.page).to(equal(1))

                    // when
                    await sut.loadMore()

                    // then
                    expect(sut.characters).to(equal(testCharacters))
                    expect(sut.isLoading).to(beFalse())
                    expect(sut.errorMessage).to(beNil())
                    expect(service.page).to(equal(1))
                }
            }
        }
    }
}
