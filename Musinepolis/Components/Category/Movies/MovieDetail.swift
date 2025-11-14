//
//  MovieDetail.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 07/11/25.
//






import SwiftUI
import MusicKit

struct MovieDetail: View {
    @Environment(ModelDataSoundtrack.self) var modelData
    @StateObject private var viewModel = TracksViewModelAM()
    var movie: Movie
   
    var movieIndex: Int? {
        modelData.movies.firstIndex(where: { $0.id == movie.id })
    }

    var body: some View {
        ZStack {
            // Fondo con blur
            AsyncImage(url: URL(string: movie.posterPath)) { phase in
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
                    
                    // 🎬 Imagen del póster
                    AsyncImage(url: URL(string: movie.posterPath)) { phase in
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

                    // 📜 Información general
                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text(movie.overview)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }

                    Divider()
                        .padding(.vertical, 8)
                    
                    // 🎵 Lista de canciones
                    if viewModel.isLoading {
                        ProgressView("Cargando soundtrack…")
                            .frame(maxWidth: .infinity)
                    } else if viewModel.tracks.isEmpty {
                        Text("No se encontraron canciones para esta película.")
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
                                    // Imagen del álbum (artwork de Apple Music)
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

                                    // Información del track
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

                                    // Botón de preview
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
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            try? await Task.sleep(for: .seconds(0.3))
            //await viewModel.fetchTracksAlbum(for: movie.albumID)
            if let soundtrackName = movie.soundtrackName {
                    await viewModel.fetchTracksByAlbumName(albumName: soundtrackName)
                }
        }
        .onDisappear {
            viewModel.stopPreview()
        }
    }
}

#Preview {
    let modelData = ModelDataSoundtrack()
    if let firstMovie = modelData.movies.first {
        MovieDetail(movie: firstMovie)
            .environment(modelData)
    } else {
        Text("No movie data available")
    }
}
