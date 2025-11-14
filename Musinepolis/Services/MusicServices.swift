//
//  MusicServices.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 14/11/25.
//

import Foundation
import Combine
import MusicKit
import AVFoundation

typealias AppleMusicTrack = MusicKit.Track


class MusicService: ObservableObject {

    @Published var songs: [Song] = []
    @Published var tracks: [AppleMusicTrack] = []
    @Published var albums: [Album] = []
    @Published var authorizationStatus: MusicAuthorization.Status = .notDetermined
    
    private var player: AVPlayer?
    
    init() {
        Task {
            await requestAuthorization()
        }
    }

    func requestAuthorization() async {
        authorizationStatus = await MusicAuthorization.request()
    }

    func searchSongs(query: String) async {
        guard authorizationStatus == .authorized else { return }

        do {
            var request = MusicCatalogSearchRequest(term: query, types: [Song.self])
            request.limit = 25

            let response = try await request.response()
            await MainActor.run {
                self.songs = Array(response.songs)
            }

        } catch {
            print("Error searching songs: \(error)")
        }
    }
    
    //function to load albums
    func searchAlbums(query: String) async {
        guard authorizationStatus == .authorized else { return }
        
        do {
            var request = MusicCatalogSearchRequest(term: query, types: [Album.self])
            request.limit = 25
            
            let response = try await request.response()
            self.albums = Array(response.albums)
            
        } catch {
            print("Error searching albums: \(error)")
        }
    }
    
    //function to load songs from specific album
    
    func loadAlbumSongs(albumId: String) async {
        guard authorizationStatus == .authorized else { return }

        do {
            let albumID = MusicItemID(albumId)

            // Request para obtener el álbum
            let request = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: albumID)
            let response = try await request.response()
            
            guard let album = response.items.first else {
                print("No se encontró el álbum con id \(albumId)")
                self.songs = []
                return
            }

            // Cargamos canciones del álbum
            let fullAlbum = try await album.with([.tracks])

            // tracks es MusicItemCollection<Track>, lo convertimos a [Song]
            if let tracks = fullAlbum.tracks {
                // Filtramos solo los tracks que son Songs
                self.songs = tracks.compactMap { track in
                    track as? Song
                }
            } else {
                self.songs = []
            }

        } catch {
            print("Error loading album tracks:", error)
            self.songs = []
        }
    }
    
    // Agregar esta función a MusicService
    
    func searchAndLoadAlbum(query: String) async -> [AppleMusicTrack] {
            guard authorizationStatus == .authorized else { return [] }
            
            do {
                var searchRequest = MusicCatalogSearchRequest(term: query, types: [Album.self])
                searchRequest.limit = 5
                
                let searchResponse = try await searchRequest.response()
                
                guard let firstAlbum = searchResponse.albums.first else {
                    print("❌ No se encontró el álbum: \(query)")
                    return []
                }
                
                print("✅ Álbum encontrado: \(firstAlbum.title)")
                
                let albumWithTracks = try await firstAlbum.with([.tracks])
                
                guard let tracks = albumWithTracks.tracks else {
                    print("❌ El álbum no tiene tracks disponibles")
                    return []
                }
                
                let trackArray = Array(tracks)
                print("✅ Tracks encontrados: \(trackArray.count)")
                
                self.tracks = trackArray
                return trackArray
                
            } catch {
                print("❌ Error buscando álbum: \(error)")
                return []
            }
        }
        
        // ✅ Preview para Track
        func previewURL(for track: AppleMusicTrack) -> URL? {
            track.previewAssets?.first?.url
        }
    
    //Preview player
    func previewURL(for song: Song) -> URL? {
        song.previewAssets?.first?.url
    }
}
