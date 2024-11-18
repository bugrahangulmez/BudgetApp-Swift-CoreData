//
//  TagsView.swift
//  BudgetApp
//
//  Created by Bugrahan on 18.11.2024.
//

import SwiftUI

struct TagsView: View {
    
    @FetchRequest(sortDescriptors: []) var tags: FetchedResults<Tag>
    @Binding var selectedTags: Set<Tag>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags) { tag in
                    Text(tag.name ?? "")
                        .padding(10)
                        .background(selectedTags.contains(tag) ? Color.blue : Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .onTapGesture {
                            if selectedTags.contains(tag) {
                                selectedTags.remove(tag)
                            } else {
                                selectedTags.insert(tag)
                            }
                        }
                }
                .foregroundStyle(.white)
            }
        }
    }
}
    
struct TagsView_PreviewContainer: View {
    
    @State private var selectedTags: Set<Tag> = []
    var body: some View {
        TagsView(selectedTags: $selectedTags)
    }
}

#Preview {
    TagsView_PreviewContainer()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
