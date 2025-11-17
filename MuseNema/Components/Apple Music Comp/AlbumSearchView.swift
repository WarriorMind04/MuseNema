//
//  AlbumSearchView.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 16/11/25.
//

import SwiftUI

struct AlbumSearchView: View {

    @StateObject private var musicService = MusicService()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List(musicService.albums, id: \.id) { album in
                AlbumRowView(album: album)
            }
            //.navigationTitle("Album Search")
            .searchable(text: $searchText, prompt: "Search albums...") // <- Barra de búsqueda nativa
            .onSubmit(of: .search) {
                // Se ejecuta cuando el usuario presiona "Buscar" en el teclado
                Task {
                    await musicService.searchAlbums(query: searchText)
                }
            }
        }
    }
}

#Preview {
    AlbumSearchView()
}
