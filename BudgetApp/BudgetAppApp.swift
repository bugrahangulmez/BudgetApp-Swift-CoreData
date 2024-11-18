//
//  BudgetAppApp.swift
//  BudgetApp
//
//  Created by Bugrahan on 16.11.2024.
//

import SwiftUI

@main
struct BudgetAppApp: App {
    let persistenceController:  PersistenceController
    let tagsSeeder: TagsSeeder
    
    
    init() {
        persistenceController = PersistenceController.shared
        tagsSeeder = TagsSeeder(context: persistenceController.container.viewContext)
    }
    

    var body: some Scene {
        WindowGroup {
            NavigationStack{
                BudgetListScreen()
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .onAppear {
                let hasSeeddedTags = UserDefaults.standard.bool(forKey: "hasSeeddedTags")
                if !hasSeeddedTags {
                    do {
                        try tagsSeeder.seed(["Food","Dining", "Travel", "Entertainment", "Shopping", "Transportation", "Utilities", "Groceries", "Health", "Education"])
                        UserDefaults.standard.set(true, forKey: "hasSeeddedTags")
                    } catch {
                        print("Error seeding tags")
                    }
                }
            }
        }
    }
}
