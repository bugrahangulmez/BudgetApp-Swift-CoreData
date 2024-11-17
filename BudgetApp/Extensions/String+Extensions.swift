//
//  String+Extensions.swift
//  BudgetApp
//
//  Created by Bugrahan on 16.11.2024.
//

import Foundation

extension String {
    
    var isEmptyOrWhitespace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
