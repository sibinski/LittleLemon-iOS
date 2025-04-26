//
//  LittleLemon_iOSApp.swift
//  LittleLemon-iOS
//
//  Created by Eugene Sibinski on 06.04.2025.
//

import SwiftUI

@main
struct LittleLemon_iOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
