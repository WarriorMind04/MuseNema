//
//  GameDetail.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 10/11/25.
//

import SwiftUI

struct GameDetail: View {
    @Environment(ModelDataSoundtrack.self) var modelData
    var game: Game

    var gameIndex: Int? {
        modelData.games.firstIndex(where: { $0.id == game.id })
    }

    var body: some View {
        ScrollView {
            VStack {
                // ✅ Usa AsyncImage directamente para cargar desde la URL
                AsyncImage(url: URL(string: game.posterPath)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(12)
                            .shadow(radius: 8)
                    case .failure:
                        Image(systemName: "film")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding(.bottom, 10)

                VStack(alignment: .leading, spacing: 12) {
                    Text(game.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Divider()

                    Text("About \(game.title)")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(game.platform)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
        }
        .navigationTitle(game.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let modelData = ModelDataSoundtrack()
    if let firstGame = modelData.games.first {
        GameDetail(game: firstGame)
            .environment(modelData)
    } else {
        Text("No movie data available")
    }
}
