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
    @StateObject private var viewModel = SoundtrackViewModel()
    var item: MediaItem
   
    var body: some View {
        ZStack {
            // Fondo blur
            backgroundImage
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Imagen principal
                    posterImage
                    
                    // Información
                    mediaInfo
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                    // Lista de canciones
                    soundtrackSection
                }
                .padding()
            }
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            try? await Task.sleep(for: .seconds(0.3))
            await viewModel.fetchSoundtrack(for: item)
        }
        .onDisappear {
            viewModel.stopPreview()
        }
    }
    
    // MARK: - Subviews
    
    private var backgroundImage: some View {
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
            case .failure:
                Color.black.opacity(0.6)
            @unknown default:
                EmptyView()
            }
        }
        .ignoresSafeArea()
    }
    
    private var posterImage: some View {
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
    }
    
    private var mediaInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(item.overview)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder
    private var soundtrackSection: some View {
        if viewModel.isLoading {
            ProgressView("Cargando soundtrack…")
                .frame(maxWidth: .infinity)
        } else if let error = viewModel.errorMessage {
            errorView(message: error)
        } else if !viewModel.tracks.isEmpty {
            tracksList
        } else if !viewModel.songs.isEmpty {
            songsList
        } else {
            emptyStateView
        }
    }
    
    private var tracksList: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader
            
            ForEach(viewModel.tracks) { track in
                TrackRowView(
                    track: track,
                    onPlay: { viewModel.playPreview(track: track) }
                )
            }
        }
    }
    
    private var songsList: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader
            
            ForEach(viewModel.songs) { song in
                SongRowVieww(
                    song: song,
                    onPlay: { viewModel.playPreview(song: song) }
                )
            }
        }
    }
    
    private var sectionHeader: some View {
        Text("Soundtrack")
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.bottom, 5)
    }
    
    private var emptyStateView: some View {
        Text("No se encontraron canciones para este soundtrack.")
            .font(.subheadline)
            .foregroundColor(.gray)
    }
    
    private func errorView(message: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.orange)
            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

