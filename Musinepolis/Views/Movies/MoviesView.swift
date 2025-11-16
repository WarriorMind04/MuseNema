//
//  HomeView.swift
//  Musinepolis
//
//  Created by José Miguel Guerrero Jiménez on 05/11/25.
//

import SwiftUI

struct MoviesView: View {
    
        var body: some View {
            
             
                
                
                /*CategoryMovieView()
                    .environment(ModelDataSoundtrack())*/
            //New component reusable and much more scalable
            CategoryMediaView(
                        items: MDSoundtrack().movies,
                        categories: MDSoundtrack().movieCategories,
                        title: "Movies"
                    )
                    .environment(MDSoundtrack())
            
            
        }
}

#Preview {
    MoviesView()
        
}
