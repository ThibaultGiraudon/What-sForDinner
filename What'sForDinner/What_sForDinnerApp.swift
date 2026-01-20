//
//  What_sForDinnerApp.swift
//  What'sForDinner
//
//  Created by Thibault Giraudon on 20/01/2026.
//

import SwiftUI
import CoreData

@main
struct What_sForDinnerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
