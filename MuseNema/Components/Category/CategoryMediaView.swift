//
//  CategoryMediaView.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 16/11/25.
//

import SwiftUI

/*struct CategoryMediaView: View {
    @Environment(MDSoundtrack.self) var modelData
    @State private var isSearch = ""
    
    // Si luego quieres activar búsqueda:
    /*
    var filteredMedia: [MediaItem] {
        modelData.searchMedia(query: isSearch)
    }
    */
    
    var body: some View {
        
        NavigationSplitView {
            ScrollView {
                
                // Carrusel principal (usa tus MediaItems)
                CardsCarrusel(items: modelData.media) { item in
                    item.posterPath
                }
                //.padding(.bottom, 30)
                
                // Lista por categorías
                ForEach(modelData.mediaCategories.keys.sorted(), id: \.self) { key in
                    if let items = modelData.mediaCategories[key] {
                        CategoryRowMedia(categoryName: key, items: items)
                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Media")
            .searchable(text: $isSearch, prompt: "Search for any soundtrack")
            
        } detail: {
            Text("Select an item")
        }
    }
}*/
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
                
                CardsCarrusel(items: items) { item in
                    item.posterPath
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
