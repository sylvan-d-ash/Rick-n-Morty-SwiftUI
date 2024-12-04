//
//  ContentView.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 02/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedStatus: Character.Status?

    @StateObject private var viewModel = CharactersViewModel(service: DataService())

    var body: some View {
        NavigationStack {
            VStack {
                FiltersView(selectedStatus: $selectedStatus)
                .padding(.horizontal)
                .onChange(of: selectedStatus) { oldStatus, newStatus in
                    viewModel.filterCharacters(withStatus: newStatus)
                }

                List {
                    ForEach(viewModel.characters, id: \.id) { character in
                        ZStack {
                            NavigationLink(destination: CharacterDetails(character: character)) {
                                EmptyView()
                            }
                            .opacity(0)

                            CharacterRow(character: character)
                                .onAppear {
                                    if viewModel.characters.last == character {
                                        Task {
                                            await viewModel.loadMore()
                                        }
                                    }
                                }
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 7.5, leading: 0, bottom: 7.5, trailing: 0))
                        .listRowBackground(Color.clear)
                    }

                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal)
            }
            .navigationTitle("Characters")
            .task {
                await viewModel.fetchCharacters()
            }
        }
    }
}

#Preview {
    ContentView()
}
