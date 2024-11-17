//
//  Budget+Extensions.swift
//  BudgetApp
//
//  Created by Bugrahan on 16.11.2024.
//

import Foundation
import CoreData

extension Budget {
    
    static func exist(context: NSManagedObjectContext, title: String) -> Bool {
        let request = NSFetchRequest<Budget>(entityName: "Budget")
        request.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let results = try context.fetch(request)
            return !results.isEmpty
        } catch {
            return false
        }
    }
    
}
