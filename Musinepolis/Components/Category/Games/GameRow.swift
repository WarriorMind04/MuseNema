//
//  GameRow.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 10/11/25.
//

import SwiftUI

struct GameRow: View {
    var categoryName: String
    var items: [Game]

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { game in
                        NavigationLink {
                            GameDetail(game: game)
                        } label: {
                           GameItem(game: game)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

#Preview {
    let modelData = ModelDataSoundtrack()
    let firstCategory = modelData.gameCategories.keys.sorted().first ?? "Games"
    let items = modelData.gameCategories[firstCategory] ?? []
    return GameRow(categoryName: firstCategory, items: items)
        .environment(modelData)
}
