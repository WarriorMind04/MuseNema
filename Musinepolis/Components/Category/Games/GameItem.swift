//
//  GameItem.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 10/11/25.
//

import SwiftUI

struct GameItem: View {
    var game: Game

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: game.posterPath)) { phase in
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

            Text(game.title)
                .foregroundStyle(.primary)
                .font(.caption)
                .lineLimit(1)
        }
        .padding(.leading, 15)
    }

}

#Preview {
    let model = ModelDataSoundtrack()
    if let game = model.games.first {
        GameItem(game: game)
    } else {
        Text("No preview data")
    }
}

