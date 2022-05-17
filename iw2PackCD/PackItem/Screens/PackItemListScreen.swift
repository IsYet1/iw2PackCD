//
//  PackItemListScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import SwiftUI

struct PackItemListScreen: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showForm: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PackItem.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<PackItem>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    PackItemListCell(item: item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Pack Items")
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
                PackItemFormScreen()
            })
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

struct PackItemListCell: View {
    let item: PackItem
    var body: some View {
        VStack {
            NavigationLink {
                //                PackItemEditScreen(packItemVM: PackItemViewModel(packItem: item))
                PackItemEditScreen(packItem: item)
                //                Text("\(item.packItemName!)")
            } label: {
                Text(item.packItemName)
            }
            Text(item.categoryName)
        }
    }
}

struct PackItemListScreen_Previews: PreviewProvider {
    static var previews: some View {
        PackItemListScreen()
    }
}
