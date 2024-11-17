//
//  BudgetListScreen.swift
//  BudgetApp
//
//  Created by Bugrahan on 16.11.2024.
//

import SwiftUI

struct BudgetListScreen: View {
    
    @State private var isPresented = false
    @FetchRequest(sortDescriptors: []) private var budgets: FetchedResults<Budget>
    
    var body: some View {
        VStack {
            List(budgets) { budget in
                NavigationLink {
                    BudgetDetailScreen(budget: budget)
                } label: {
                    BudgetCellView(budget: budget)
                }
            }
        }
        .navigationTitle("Budget App")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Budget") {
                    isPresented.toggle()
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            AddBudgetScreen()
        }
            
    }
}

#Preview {
    NavigationStack {
        BudgetListScreen()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


