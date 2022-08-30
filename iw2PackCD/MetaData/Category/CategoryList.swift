//
//  CategoryList.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 27-Apr-22.
//

import SwiftUI

struct CategoryList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showForm: Bool = false
    @State private var selectedCategory: Category? = nil
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Category>
    
    var body: some View {
        NavigationSplitView(
            sidebar: {
                List(items, id: \.self.id,
                     selection: $selectedCategory,
                     rowContent: {category in NavigationLink(category.name!, value: category)}
                )
                
            },
            detail: {
                if (selectedCategory != nil) {
                    CategoryPackItemsList(category: selectedCategory!)
                } else {
                    Text("Select a category")
                }
            })
        
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    CategoryItemCell(item: item)
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .navigationTitle("Categories")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    EditButton()
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Add") {
//                        self.showForm = true
//                    }
//                }
//            }
//            .sheet(isPresented: $showForm, content: {
//                CategoryFormScreen()
//            })
//            Text("Select an item")
//        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//struct CategoryList_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryList()
//    }
//}

struct CategoryItemCell: View {
    let item: Category
    var body: some View {
        NavigationLink {
            CategoryPackItemsList(category: item)
//            Text("Item at \(item.name ?? "No Category")")
        } label: {
            Text(item.name ?? "No category")
        }
    }
}
