//
//  CardsCarrusel.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 05/11/25.
//

import SwiftUI

struct CardsCarrusel: View {
    
    let colors: [Color] = [.red, .blue, .yellow, .green, .purple]

    var body: some View {
        GeometryReader { outerGeo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(colors, id: \.self) { color in
                        GeometryReader { geo in
                            let midX = geo.frame(in: .global).midX
                            let screenMidX = outerGeo.size.width / 2
                            let distance = abs(screenMidX - midX)
                            let scale = max(0.8, 1 - distance / 600)
                            let rotation = (screenMidX - midX) / 20

                            MainComponentCard(color: color)
                                //.frame(width: 300, height: 420)
                                .cornerRadius(20)
                                .shadow(radius: 10)
                                .scaleEffect(scale)
                                .rotation3DEffect(
                                    .degrees(Double(rotation)),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                                .animation(.easeOut(duration: 0.3), value: scale)
                        }
                        .frame(width: 300, height: 420)
                    }
                }
                .padding(.horizontal, (outerGeo.size.width - 500) / 2)
                .padding(.vertical, 50)
            }
        }
    }
}

#Preview {
    CardsCarrusel()
}
