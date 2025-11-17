//
//  CategoryMediaItem.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 16/11/25.
//

import SwiftUI


struct CategoryMediaItem: View {
    var item: MediaItem

    var body: some View {
        VStack(alignment: .leading) {

            AsyncImage(url: URL(string: item.posterPath)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 155, height: 155)

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 155, height: 155)
                        .clipped()
                        .cornerRadius(5)

                case .failure:
                    Image(systemName: "film")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 155, height: 155)
                        .foregroundColor(.gray)

                @unknown default:
                    EmptyView()
                }
            }

            Text(item.title)
                .foregroundStyle(.primary)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 120, alignment: .leading)
        }
        .padding(.leading, 15)
    }
}
