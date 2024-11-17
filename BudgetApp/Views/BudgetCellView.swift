//
//  BudgetCellView.swift
//  BudgetApp
//
//  Created by Bugrahan on 16.11.2024.
//

import SwiftUI

struct BudgetCellView: View {
    let budget: Budget
    var body: some View {
        HStack {
            Text(budget.title ?? "")
            Spacer()
            Text(budget.limit, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
    }
}
