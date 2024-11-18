//
//  Persistence.swift
//  BudgetApp
//
//  Created by Bugrahan on 16.11.2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let firstBudget = Budget(context: viewContext)
        firstBudget.title = "Entertainment"
        firstBudget.limit = 500
        firstBudget.dateCreated = Date()
        
        let secondBudget = Budget(context: viewContext)
        secondBudget.title = "Groceries"
        secondBudget.limit = 300
        secondBudget.dateCreated = Date()
        
        let milk = Expense(context: viewContext)
        milk.title = "Milk"
        milk.amount = 5.45
        milk.dateCreated = Date()
        
        let cookie = Expense(context: viewContext)
        cookie.title = "Cookie"
        cookie.amount = 3.45
        cookie.dateCreated = Date()
        
        secondBudget.addToExpenses(milk)
        secondBudget.addToExpenses(cookie)
        
        // insert tags
        let commonTags = ["Food","Dining", "Travel", "Entertainment", "Shopping", "Transportation", "Utilities", "Groceries", "Health", "Education"]
        commonTags.forEach { tagName in
            let tag = Tag(context: viewContext)
            
            if ["Food", "Groceries"].contains(tagName) {
                cookie.addToTags(tag)
            }
            tag.name = tagName
        }

        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "BudgetAppModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
