//
//  BudgetDetailScreen.swift
//  BudgetApp
//
//  Created by Bugrahan on 17.11.2024.
//

import SwiftUI

struct BudgetDetailScreen: View {
    let budget: Budget
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var title: String = ""
    @State var amount: Double?
    @State private var selectedTags: Set<Tag> = []
    
    @FetchRequest(sortDescriptors: []) private var expenses: FetchedResults<Expense>
    
    init(budget: Budget) {
        self.budget = budget
        _expenses = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "budget == %@", budget))
    }
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace && amount != nil && amount! > 0 && !selectedTags.isEmpty
    }
    
    private var totalExpenses: Double {
//        expenses.reduce(0.0) { $0 + $1.amount } // This is the same with the below code
        return expenses.reduce(0) { partialResult, expense in
            partialResult + expense.amount
        }
    }
    
    private var remaining: Double {
        budget.limit - totalExpenses
    }
    
    private func deleteExpense(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let expense = expenses[index]
            viewContext.delete(expense)
            
            do {
                try viewContext.save()
            } catch {
                print("Error deleting expense: \(error.localizedDescription)")
            }
        }
    }
    
    private func addExpense() { 
        let expense = Expense(context: viewContext)
        expense.title = title
        expense.amount = amount ?? 0.0
        expense.dateCreated = Date()
        expense.tags = NSSet(set: selectedTags)
   
        budget.addToExpenses(expense)
        
        do {
            try viewContext.save()
            title = ""
            amount = nil
        } catch {
            print("Error saving expense: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        Form {
            Section("New Expense") {
                TextField("Title", text: $title)
                    .presentationDetents([.medium])
                TextField("Amount", value: $amount, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                
                TagsView(selectedTags: $selectedTags)
                
                Button {
                    addExpense()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isFormValid)
            }
            
            Section("Expenses") {
                List {
                    VStack(alignment: .leading) {
                        Text("Total expenses: \(totalExpenses, format: .currency(code: Locale.currencyCode))")
                            .font(.headline)
                        Text("Remaining: \(remaining, format: .currency(code: Locale.currencyCode))")
                            .font(.headline)
                            .foregroundColor(remaining >= 0 ? .green : .red)
                    }
                    
                    ForEach(expenses) { expense in
                        ExpenseCellView(expense: expense)
                    }
                    .onDelete(perform: deleteExpense)
                }
            }
        }
        .navigationTitle(budget.title ?? "")
    }
}

struct BudgetDetailScreen_PreviewProvider: View {
    @FetchRequest(sortDescriptors: []) private var budgets: FetchedResults<Budget>
    
    var body: some View {
        NavigationStack {
            BudgetDetailScreen(budget: budgets.first(where: { $0.title == "Groceries" })!)
        }
    }
}
    

#Preview {
    NavigationStack {
        BudgetDetailScreen_PreviewProvider()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
