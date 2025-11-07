//
//  Game.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 07/11/25.
//

import Foundation
import SwiftUI

struct Game: Codable {
    let id: Int
    let title: String
    let platform: String
    let releaseDate: String
    let albumId: Int?
    var category: Category
       enum Category: String, CaseIterable, Codable {
           case new = "New Releases"
           case featured = "Featured Movies"
           case top = "Top Movies"
       }
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}

