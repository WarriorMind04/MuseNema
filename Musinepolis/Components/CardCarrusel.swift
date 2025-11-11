//
//  CardCarrusel.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 11/11/25.
//

import SwiftUI

struct CardCarrusel<Item: Identifiable>: View {
    let items: [Item]
    let imageURL: (Item) -> String
    
    var body: some View {
        
        TabView {
            ForEach(items, id: \.id) { item in
                AsyncImage(url: URL(string: imageURL(item))) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    case .failure:
                        Image(systemName: "film")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                            .padding()
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 500)
    }
}

#Preview {
    CardCarrusel(items: ModelDataSoundtrack().movies) { movie in
        movie.posterPath
    }
}
