//
//  CategoryTVSeriesView.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 07/11/25.
//

import SwiftUI

struct CategoryTVSeriesView: View {
    @Environment(ModelDataSoundtrack.self) var modelData

    var body: some View {
        
        NavigationSplitView {
            ScrollView {
                
                // ✅ Imagen destacada (Featured)
                CardCarrusel(items: ModelDataSoundtrack().tvSeries) { serie in
                    serie.posterPath
                }
                

                // ✅ Lista por categorías
                ForEach(modelData.serieCategories.keys.sorted(), id: \.self) { key in
                    if let items = modelData.serieCategories[key] {
                        TVSeriesRow(categoryName: key, items: items)
                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("TV Series")
        } detail: {
            Text("Select a movie")
        }
    }
}

#Preview {
    CategoryTVSeriesView()
        .environment(ModelDataSoundtrack())
}
