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
                .strokeBorder(
                    character.status == .unknown ? Color.purple.opacity(0.2) : Color.clear,
                    lineWidth: 1
                )
        )
        .background(
            character.status.color
                .clipShape(RoundedRectangle(cornerRadius: 12))
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

private extension Character.Status {
    var color: Color {
        switch self {
        case .alive: return Color(red: 0.917, green: 0.966, blue: 0.991)
        case .dead: return Color(red: 1.001, green: 0.902, blue: 0.922)
        case .unknown: return .white
        }
    }
}
