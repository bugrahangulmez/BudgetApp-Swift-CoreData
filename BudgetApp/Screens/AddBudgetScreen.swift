//
//  AddBudgetScreen.swift
//  BudgetApp
//
//  Created by Bugrahan on 16.11.2024.
//

import SwiftUI

struct AddBudgetScreen: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var title: String = ""
    @State private var limit: Double?
    @State private var errorMessage: String = ""
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace && limit != nil && Double(limit!) > 0
    }
    
    private func saveBudget() {
        let budget = Budget(context: viewContext)
        budget.title = title
        budget.limit = limit ?? 0.0
        budget.dateCreated = Date()
        
        do {
            try viewContext.save()
        } catch {
            errorMessage = "Error saving budget: \(error.localizedDescription)"
            print("Error saving budget: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        Form {
            Text("New Budget")
                .font(.title)
            
            TextField("Title", text: $title)
                .presentationDetents([.medium])
            
            TextField("Limit", value: $limit, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                
            Button {
                print("Save button tapped")
                if !Budget.exist(context: viewContext, title: title) {
                    saveBudget()
                } else {
                    
                }
                
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!isFormValid)
            
            Text(errorMessage)
                .foregroundColor(.red)
                .font(.caption)
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    AddBudgetScreen()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
