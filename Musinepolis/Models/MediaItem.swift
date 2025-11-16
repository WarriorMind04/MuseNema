//
//  MediaItem.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 13/11/25.
//

import Foundation


struct MediaItem: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var type: MediaType
    var posterPath: String
    var overview: String
    var category: String?
    var albumID: String?
    var soundtrackName: String?
    
    enum MediaType: String, Codable, CaseIterable, Identifiable {
        case movie, series, game
        var id: String { self.rawValue }
    }
    
    enum Category: String, CaseIterable, Codable {
            case new = "New Releases"
            case featured = "Featured"
            case top = "Top"
        }
    // Ignorar el id al decodificar
        private enum CodingKeys: String, CodingKey {
            case title, type, posterPath, overview, category, albumID, soundtrackName
        }
}
