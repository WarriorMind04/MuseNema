//
//  ScreenTitle.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 05/11/25.
//

import SwiftUI

struct ScreenTitle: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color.blue.opacity(0.8))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
    }
}

#Preview {
    ScreenTitle(title: "Hello")
}
