//
//  CharacterRow.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 03/12/2024.
//

import SwiftUI

struct CharacterRow: View {
    var character: Character

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.primary)

                Text(character.species)
                    .font(.system(size: 20))
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 5)

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.purple.opacity(0.2), lineWidth: 1)
        )
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

    return CharacterRow(character: character)
}
