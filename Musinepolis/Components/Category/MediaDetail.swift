//
//  MediDetail.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 16/11/25.
//

import SwiftUI
import MusicKit

struct MediaDetail: View {
    @Environment(MDSoundtrack.self) var modelData
    @StateObject private var viewModel = TracksViewModelAM()
    var item: MediaItem
   
    var body: some View {
        ZStack {
            // Fondo blur
            AsyncImage(url: URL(string: item.posterPath)) { phase in
                switch phase {
                case .empty:
                    Color.black.opacity(0.6)
                case .success(let image):
                    image
                        .resizable()
                        .blur(radius: 20)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.black.opacity(0.1),
                                    Color.black.opacity(0.2),
                                    Color.clear
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .ignoresSafeArea()
                case .failure:
                    Color.black.opacity(0.6)
                @unknown default:
                    EmptyView()
                }
            }
            .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Imagen principal
                    AsyncImage(url: URL(string: item.posterPath)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView().frame(height: 300)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
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

                    // Información
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text(item.overview)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }

                    Divider()
                        .padding(.vertical, 8)
                    
                    // Lista de canciones
                    if viewModel.isLoading {
                        ProgressView("Cargando soundtrack…")
                            .frame(maxWidth: .infinity)
                    } else if viewModel.tracks.isEmpty {
                        Text("No se encontraron canciones para este soundtrack.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    } else {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Soundtrack")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.bottom, 5)
                            
                            ForEach(viewModel.tracks) { song in
                                HStack(spacing: 10) {
                                    
                                    if let artwork = song.artwork {
                                        ArtworkImage(artwork, width: 60, height: 60)
                                            .cornerRadius(8)
                                    } else {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 60, height: 60)
                                            .overlay(
                                                Image(systemName: "music.note")
                                                    .foregroundColor(.gray)
                                            )
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(song.title)
                                            .font(.headline)
                                            .lineLimit(1)
                                        
                                        Text(song.artistName)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }

                                    Spacer()

                                    if song.previewAssets?.first != nil {
                                        Button {
                                            viewModel.playPreview(song)
                                        } label: {
                                            Image(systemName: "play.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.pink)
                                        }
                                    } else {
                                        Image(systemName: "play.circle")
                                            .font(.title2)
                                            .foregroundColor(.gray.opacity(0.5))
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            try? await Task.sleep(for: .seconds(0.3))

            if let soundtrackName = item.soundtrackName {
                await viewModel.fetchTracksByAlbumName(albumName: soundtrackName)
            }
        }
        .onDisappear {
            viewModel.stopPreview()
        }
    }
}

/*import SwiftUI
import MusicKit

struct MediaDetail: View {
    @Environment(MDSoundtrack.self) var modelData
    @StateObject private var viewModel = TracksViewModelAM()
    var item: MediaItem
   
    var body: some View {
        ZStack {
            // Fondo blur
            AsyncImage(url: URL(string: item.posterPath)) { phase in
                switch phase {
                case .empty:
                    Color.black.opacity(0.6)
                case .success(let image):
                    image
                        .resizable()
                        .blur(radius: 20)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.black.opacity(0.1),
                                    Color.black.opacity(0.2),
                                    Color.clear
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .ignoresSafeArea()
                case .failure:
                    Color.black.opacity(0.6)
                @unknown default:
                    EmptyView()
                }
            }
            .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Imagen principal
                    AsyncImage(url: URL(string: item.posterPath)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView().frame(height: 300)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
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

                    // Información
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text(item.overview)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }

                    Divider()
                        .padding(.vertical, 8)
                    
                    // Lista de canciones
                    if viewModel.isLoading {
                        ProgressView("Cargando soundtrack…")
                            .frame(maxWidth: .infinity)
                    } else if viewModel.tracks.isEmpty {
                        Text("No se encontraron canciones para este soundtrack.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    } else {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Soundtrack")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.bottom, 5)
                            
                            ForEach(viewModel.tracks) { song in
                                HStack(spacing: 10) {
                                    
                                    if let artwork = song.artwork {
                                        ArtworkImage(artwork, width: 60, height: 60)
                                            .cornerRadius(8)
                                    } else {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 60, height: 60)
                                            .overlay(
                                                Image(systemName: "music.note")
                                                    .foregroundColor(.gray)
                                            )
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(song.title)
                                            .font(.headline)
                                            .lineLimit(1)
                                        
                                        Text(song.artistName)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }

                                    Spacer()

                                    if song.previewAssets?.first != nil {
                                        Button {
                                            viewModel.playPreview(song)
                                        } label: {
                                            Image(systemName: "play.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.pink)
                                        }
                                    } else {
                                        Image(systemName: "play.circle")
                                            .font(.title2)
                                            .foregroundColor(.gray.opacity(0.5))
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            try? await Task.sleep(for: .seconds(0.3))

            switch item.type {
            case .movie, .game:
                // Buscar por albumID si existe
                if let albumID = item.albumID {
                    await viewModel.fetchTracksByAlbumID(albumID: albumID)
                }
            case .series:
                // Buscar por playlist usando nombre del soundtrack o de la serie
                let query = item.soundtrackName ?? "\(item.title) soundtrack"
                await viewModel.fetchTracksByPlaylistName(playlistName: query)
            }
        }
        .onDisappear {
            viewModel.stopPreview()
        }
    }
}*/
