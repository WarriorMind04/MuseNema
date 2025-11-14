//
//  TracksViewModelAM.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 14/11/25.
//

import Foundation
import MusicKit
import Combine

//typealias AppleMusicTrack = MusicKit.Track


class TracksViewModelAM: ObservableObject {
    
    //@Published var tracks: [Song] = []
    @Published var tracks: [AppleMusicTrack] = []
        @Published var isLoading = false
        
        private let musicService = MusicService()
        
        
    func fetchTracksByAlbumName(albumName: String) async {
           isLoading = true
           defer { isLoading = false }
           
           let foundTracks = await musicService.searchAndLoadAlbum(query: albumName)
           self.tracks = foundTracks
       }
       
       func playPreview(_ track: AppleMusicTrack) {
           guard let previewURL = musicService.previewURL(for: track) else {
               print("No hay preview disponible para este track")
               return
           }
           PreviewPlayer.shared.playPreview(url: previewURL)
       }
        
        func stopPreview() {
            PreviewPlayer.shared.stop()
        }
}
