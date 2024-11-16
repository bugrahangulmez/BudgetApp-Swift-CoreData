//
//  BudgetAppApp.swift
//  BudgetApp
//
//  Created by Bugrahan on 16.11.2024.
//

import SwiftUI

@main
struct BudgetAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
