//
//  FilterScreen.swift
//  BudgetApp
//
//  Created by Bugrahan on 18.11.2024.
//

import SwiftUI

struct FilterScreen: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedTags: Set<Tag> = []
    @State private var filteredExpenses: [Expense] = []
    @FetchRequest(sortDescriptors: []) private var expenses: FetchedResults<Expense>
    
    private func filterTags() {
        // Filter tags
        let selectedTagNames = selectedTags.map { $0.name ?? "" }
        
        let request = Expense.fetchRequest()
        request.predicate = NSPredicate(format: "ANY tags.name IN %@", selectedTagNames)
        
        do {
            filteredExpenses = try viewContext.fetch(request)

        } catch {
            print("Error filtering expenses: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Section("Filter by tags") {
                TagsView(selectedTags: $selectedTags)
                    .onChange(of: selectedTags, filterTags)
            }
            List(filteredExpenses) { expense in
                ExpenseCellView(expense: expense)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button("Show All") {
                    filteredExpenses = expenses.map { $0 }
                }
                Spacer()
            }
        }
        .padding()
        .navigationTitle("Filter")
    }
}

#Preview {
    NavigationStack {
        FilterScreen()
    }
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
