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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Category>
//    private var items1 = Category.all()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    ItemCell(item: item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        self.showForm = true
                    }
                }
            }
            .sheet(isPresented: $showForm, content: {
                CategoryFormScreen()
            })
            Text("Select an item")
        }
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

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
    }
}

struct ItemCell: View {
    let item: Category
    var body: some View {
        NavigationLink {
            Text("Item at \(item.name!)")
        } label: {
            Text(item.name!)
        }
    }
}
