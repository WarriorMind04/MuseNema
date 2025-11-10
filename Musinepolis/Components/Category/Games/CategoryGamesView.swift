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
            List {
                
                // ✅ Imagen destacada (Featured)
                if let featured = modelData.featuredGames.first {
                    AsyncImage(url: URL(string: featured.posterPath)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 500)
                                .clipped()
                        case .failure:
                            Image(systemName: "film")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .listRowInsets(EdgeInsets())
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
