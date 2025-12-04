//
//  CategoryMediaView.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 16/11/25.
//

import SwiftUI


struct CategoryMediaView: View {
    @Environment(MDSoundtrack.self) var modelData
    @StateObject private var musicService = MusicService()
    var items: [MediaItem]
    var categories: [String: [MediaItem]]
    var title: String
    @State private var isSearch = ""

    var body: some View {
        NavigationSplitView {
            ScrollView {
                
                /*CardsCarrusel(items: items) { item in
                    item.posterPath
                }*/
                CardsCarrusel(
                    items: items,
                    imageURL: { $0.posterPath }
                ) { item in
                    MediaDetail(item: item)    // 👈 Vista destino
                }

                ForEach(categories.keys.sorted(), id: \.self) { key in
                    if let items = categories[key] {
                        CategoryRowMedia(categoryName: key, items: items)
                    }
                }
            }
            .navigationTitle(title)
            .searchable(text: $isSearch, prompt: "Search for any soundtrack")
            .onSubmit(of: .search) {
                // Se ejecuta cuando el usuario presiona "Buscar" en el teclado
                Task {
                    await musicService.searchAlbums(query: isSearch)
                }
            }

        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    CategoryMediaView(
                items: MDSoundtrack().movies,
                categories: MDSoundtrack().movieCategories,
                title: "Movies"
            )
            .environment(MDSoundtrack())
}
