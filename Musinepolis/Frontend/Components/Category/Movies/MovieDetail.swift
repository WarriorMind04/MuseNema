//
//  MovieDetail.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 07/11/25.
//

/*import SwiftUI

struct MovieDetail: View {
    @Environment(ModelDataSoundtrack.self) var modelData
    var movie: Movie

    var movieIndex: Int {
        modelData.movies.firstIndex(where: { $0.id == movie.id })!
    }

    var body: some View {
        @Bindable var modelData = modelData

        ScrollView {
            /*MapView(coordinate: landmark.locationCoordinate)
                .frame(height: 300)*/

            CircleImage(image: movie.image)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    Text(movie.title)
                        .font(.title)
                    //FavoriteButton(isSet: $modelData.movies[movieIndex].isFavorite)
                }

                

                Divider()

                Text("About \(movie.title)")
                    .font(.title2)
                Text(movie.overview)
            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let modelData = ModelDataSoundtrack()
    MovieDetail(landmark: modelData.movies[0], movie: <#Movie#>)
        .environment(modelData)
}
*/
import SwiftUI

struct MovieDetail: View {
    @Environment(ModelDataSoundtrack.self) var modelData
    var movie: Movie

    var movieIndex: Int? {
        modelData.movies.firstIndex(where: { $0.id == movie.id })
    }

    var body: some View {
        ScrollView {
            VStack {
                // ✅ Usa AsyncImage directamente para cargar desde la URL
                AsyncImage(url: URL(string: movie.posterPath)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
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
                .padding(.bottom, 10)

                VStack(alignment: .leading, spacing: 12) {
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Divider()

                    Text("About \(movie.title)")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(movie.overview)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
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


