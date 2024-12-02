//
//  ContentView.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 02/12/2024.
//

import SwiftUI

struct ContentView: View {
    private let statuses = Character.Status.allCases
    @State private var selectedStatus: Character.Status?

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    ForEach(statuses, id: \.self) { status in
                        Text(status.rawValue)
                            .padding(10)
                            .background(
                                selectedStatus == status ? Color.blue : Color.white
                            )
                            .foregroundStyle(
                                selectedStatus == status ? Color.white : Color.black
                            )
                            .overlay {
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(selectedStatus == status ? Color.blue : Color.black)
                            }
                            .clipShape(
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                            )
                            .onTapGesture {
                                if selectedStatus == status {
                                    selectedStatus = nil
                                } else {
                                    selectedStatus = status
                                }
                            }
                    }
                    Spacer()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Characters")
        }
    }
}

#Preview {
    ContentView()
}
