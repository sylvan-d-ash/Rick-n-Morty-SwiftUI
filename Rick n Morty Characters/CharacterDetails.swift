//
//  CharacterDetails.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 03/12/2024.
//

import SwiftUI

struct CharacterDetails: View {
    @Environment(\.dismiss)  private var dismiss

    var character: Character

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                ZStack(alignment: .topLeading) {
                    AsyncImage(url: URL(string: character.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } placeholder: {
                        ProgressView()
                    }

                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.black)
                            .padding()
                            .background(Circle().fill(Color.white))
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, geometry.safeAreaInsets.top)
                }
                .ignoresSafeArea()

                VStack {
                    HStack {
                        Text(character.name)
                            .font(.title)
                            .fontWeight(.bold)

                        Spacer()

                        Text(character.status.rawValue)
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(Color.cyan)
                            )
                    }

                    HStack(spacing: 5) {
                        Text(character.species)
                        Text("•")
                        Text(character.gender.rawValue)
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    .font(.subheadline)
                }
                .padding(.horizontal)
                .padding(.top, -geometry.safeAreaInsets.top)

                HStack {
                    Text("Location :")
                        .fontWeight(.bold)

                    Text(character.location)
                        .font(.subheadline)
                    Spacer()
                }
                .padding(.horizontal)

                Spacer()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    let character = Character(id: 1,
                              name: "Toxic Rick",
                              species: "Humanoid",
                              image: "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
                              status: .dead,
                              gender: .male,
                              location: "Earth"
    )

    return CharacterDetails(character: character)
}
