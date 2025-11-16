//
//  AlbumRowView.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 16/11/25.
//

import SwiftUI
import MusicKit

struct AlbumRowView: View {
    let album: Album  // Album de MusicKit
    
    var body: some View {
        HStack(spacing: 12) {
            // Portada del álbum
            if let artworkURL = album.artwork?.url(width: 100, height: 100) {
                AsyncImage(url: artworkURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 60, height: 60)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .cornerRadius(6)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            // Título y artista
            VStack(alignment: .leading, spacing: 4) {
                Text(album.title)
                    .font(.headline)
                    .lineLimit(1)

                // artistName es String no opcional en MusicKit.Album
                if !album.artistName.isEmpty {
                    Text(album.artistName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    // MusicKit.Album no es inicializable directamente para previews.
    // Muestra un placeholder para mantener el preview compilando.
    VStack(alignment: .leading, spacing: 8) {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 60, height: 60)
                .overlay(Image(systemName: "photo"))
            VStack(alignment: .leading, spacing: 4) {
                Text("Example Album")
                    .font(.headline)
                Text("Artist")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 6)
    }
    .padding()
}
