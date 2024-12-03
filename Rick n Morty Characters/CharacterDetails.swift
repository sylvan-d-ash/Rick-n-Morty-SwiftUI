//
//  CharacterDetails.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 03/12/2024.
//

import SwiftUI

struct CharacterDetails: View {
    var body: some View {
        VStack(spacing: 20) {
            ZStack(alignment: .topLeading) {
                Image("toxic_rick")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                Button(action: {
                    // handle back action
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                        .padding()
                        .background(Circle().fill(Color.white))
                }
                .padding(16)
            }

            VStack {
                HStack {
                    Text("Zephyr")
                        .font(.title)
                        .fontWeight(.bold)

                    Spacer()

                    Text("Status")
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color.cyan)
                        )
                }

                HStack(spacing: 5) {
                    Text("Elf")
                    Text("•")
                    Text("Male")
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .font(.subheadline)
            }
            .padding(.horizontal)

            HStack {
                Text("Location :")
                    .fontWeight(.bold)

                Text("Earth")
                    .font(.subheadline)
                Spacer()
            }
            .padding(.horizontal)

            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterDetails()
}
