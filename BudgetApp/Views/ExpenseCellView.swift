//
//  ExpenseCellView.swift
//  BudgetApp
//
//  Created by Bugrahan on 18.11.2024.
//

import SwiftUI

struct ExpenseCellView: View {
    
    let expense: Expense
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(expense.title ?? "")
                Spacer()
                Text(expense.amount, format: .currency(code: Locale.currencyCode))
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(expense.tags as? Set<Tag> ?? []), id: \.self) { tag in
                        Text(tag.name ?? "")
                            .padding(6)
                            .font(.caption)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                }
            }
        }
    }
}

struct ExpenseCellView_PreviewProvider: View {
    
    @FetchRequest(sortDescriptors: []) private var expenses: FetchedResults<Expense>
    
    var body: some View {
        ExpenseCellView(expense: expenses[0])
    }
}

#Preview {
    ExpenseCellView_PreviewProvider()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
