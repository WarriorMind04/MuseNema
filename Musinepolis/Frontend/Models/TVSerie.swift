//
//  TVSerie.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 07/11/25.
//

import Foundation
import SwiftUI

struct TVSerie: Codable {
    let id: Int
    let name: String
    let firstAirDate: String
    let overview: String
    let albumId: Int?  
    var category: Category
       enum Category: String, CaseIterable, Codable {
           case new = "New Releases"
           case featured = "Featured Series"
           case top = "Top Series"
       }
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
