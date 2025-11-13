//
//  CategoryGamesView.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 10/11/25.
//

import SwiftUI

struct CategoryGamesView: View {
    @Environment(ModelDataSoundtrack.self) var modelData

    var body: some View {
        
        NavigationSplitView {
            ScrollView {
                
                // ✅ Imagen destacada (Featured)
                /*CardCarrusel(items: ModelDataSoundtrack().games) { game in
                    game.posterPath
                }*/
                CardsCarrusel(items: ModelDataSoundtrack().games) { game in
                                   game.posterPath
                               }
                

                // ✅ Lista por categorías
                ForEach(modelData.gameCategories.keys.sorted(), id: \.self) { key in
                    if let items = modelData.gameCategories[key] {
                        
                        GameRow(categoryName: key, items: items)
                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Games")
        } detail: {
            Text("Select a game")
        }
    }
}

#Preview {
    CategoryGamesView()
        .environment(ModelDataSoundtrack())
}
