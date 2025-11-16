//
//  MDSoundtrack.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 16/11/25.
//

import Foundation
import Foundation
import Observation

@Observable
class MDSoundtrack {

    // Carga un solo JSON con todos los MediaItem
    var media: [MediaItem] = safeLoad("media.json") {
        didSet {
            print("✅ Cargados \(media.count) items multimedia")
        }
    }

    // MARK: - Filtros por tipo
    var movies: [MediaItem] {
        media.filter { $0.type == .movie }
    }

    var series: [MediaItem] {
        media.filter { $0.type == .series }
    }

    var games: [MediaItem] {
        media.filter { $0.type == .game }
    }

    // MARK: - Filtros por categoría
    var mediaCategories: [String : [MediaItem]] {
        Dictionary(grouping: media, by: { $0.category ?? "Uncategorized" })
    }

    var movieCategories: [String: [MediaItem]] {
        Dictionary(grouping: movies, by: { $0.category ?? "Uncategorized" })
    }

    var seriesCategories: [String: [MediaItem]] {
        Dictionary(grouping: series, by: { $0.category ?? "Uncategorized" })
    }

    var gameCategories: [String: [MediaItem]] {
        Dictionary(grouping: games, by: { $0.category ?? "Uncategorized" })
    }
}


// -------------------------------
// MARK: - Safe JSON Loader (igual)
// -------------------------------

private func safeLoad<T: Decodable>(_ filename: String) -> T where T: ExpressibleByArrayLiteral {
    do {
        return try strictLoad(filename) as T
    } catch {
        #if DEBUG
        print("safeLoad warning: \(filename) no se pudo cargar: \(error). Devolviendo vacío.")
        #endif
        return [] as T
    }
}

private func strictLoad<T: Decodable>(_ filename: String) throws -> T {
    let data: Data
    
    let candidates: [Bundle] = [.main, Bundle(for: ModelDataSoundtrack.self)]
    guard let url = candidates.compactMap({ $0.url(forResource: filename, withExtension: nil) }).first else {
        throw NSError(domain: "ModelDataSoundtrack", code: 1,
                      userInfo: [NSLocalizedDescriptionKey: "Couldn't find \(filename)"])
    }
    
    do {
        data = try Data(contentsOf: url)
    } catch {
        throw NSError(domain: "ModelDataSoundtrack", code: 2,
                      userInfo: [NSLocalizedDescriptionKey: "Couldn't load \(filename)"])
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        throw NSError(domain: "ModelDataSoundtrack", code: 3,
                      userInfo: [NSLocalizedDescriptionKey:
                                    "Couldn't parse \(filename) as \(T.self): \(error)"])
    }
}
