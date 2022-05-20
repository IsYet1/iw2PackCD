//
//  PackItemListScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import SwiftUI

struct PackItemListScreenFR: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showForm: Bool = false
    
//    @StateObject private var packItemListVm = PackItemListVM()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PackItem.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<PackItem>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    PackItemListCellFR(item: item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Pack Items FR")
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
            .sheet(isPresented: $showForm,
                   content: { PackItemAddScreen() }
            )
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

struct PackItemListCellFR: View {
    let item: PackItem
    var body: some View {
        VStack {
            NavigationLink {
                Text("Item at \(item.name!)")
            } label: {
                Text(item.name!)
            }
            Text(item.category?.name ?? "No Category")
        }
    }
}

//struct PackItemListScreenFR_Previews: PreviewProvider {
//    static var previews: some View {
//        PackItemListScreenFR()
//    }
//}
//