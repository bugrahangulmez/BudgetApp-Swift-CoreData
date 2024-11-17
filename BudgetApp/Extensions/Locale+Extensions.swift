//
//  Locale+Extensions.swift
//  BudgetApp
//
//  Created by Bugrahan on 17.11.2024.
//

import Foundation

extension Locale {
        
    static var currencyCode: String {
        return Locale.current.currency?.identifier ?? "USD"
    }
        
}

