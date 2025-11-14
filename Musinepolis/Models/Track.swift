//
//  Track.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 10/11/25.
//

import Foundation
//import MusicKit

struct Track: Codable, Identifiable {
    let id: String
       let name: String
       let previewURL: String?
       let album: Albumm?
       let artists: [Artist]
}
