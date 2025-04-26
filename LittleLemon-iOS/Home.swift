//
//  Home.swift
//  LittleLemon-iOS
//
//  Created by Eugene Sibinski on 07.04.2025.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView{Menu()
                .tabItem({Label("Menu", systemImage: "list.dash")})
        UserProfile()
                .tabItem( {Label("Profile", systemImage: "square.and.pencil")})
            
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
