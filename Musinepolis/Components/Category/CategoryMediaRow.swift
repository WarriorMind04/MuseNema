//
//  CategoryMediaRow.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 16/11/25.
//

import SwiftUI

struct CategoryRowMedia: View {
    var categoryName: String
    var items: [MediaItem]

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { item in
                        NavigationLink {
                            MediaDetail(item: item)
                        } label: {
                            CategoryMediaItem(item: item)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}


