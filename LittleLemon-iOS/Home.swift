//
//  Home.swift
//  LittleLemon-iOS
//
//  Created by Eugene Sibinski on 07.04.2025.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    var body: some View {
        TabView {
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem({
                    Label("Menu", systemImage: "list.dash")
                })
            
            UserProfile() // First instance of Profile tab
                .tabItem({
                    Label("Profile", systemImage: "square.and.pencil")
                })
                .navigationBarBackButtonHidden(true)
        }
    }
}
    #Preview {
        Home()
    }

