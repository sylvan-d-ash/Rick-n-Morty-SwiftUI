//
//  CharacterRow.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 03/12/2024.
//

import SwiftUI

struct CharacterRow: View {
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image("toxic_rick", bundle: nil)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text("Zephyr")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.primary)

                Text("Elf")
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
    CharacterRow()
}
