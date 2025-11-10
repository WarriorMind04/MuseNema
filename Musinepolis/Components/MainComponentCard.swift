//
//  MainComponentCard.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 05/11/25.
//

import SwiftUI

struct MainComponentCard: View {
    var color = Color.gray
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: 330, height: 450)
            .cornerRadius(10)
            //.foregroundStyle(Color.gray)
            
    }
}

#Preview {
    MainComponentCard(color: .blue)
}
