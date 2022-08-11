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
    
    @StateObject private var packItemListVm = PackItemListVM()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)]
    )
    private var categories: FetchedResults<Category>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PackItem.name, ascending: false)],
        animation: .default)
    private var items: FetchedResults<PackItem>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(packItemListVm.groupedSortedFiltered, id:\.key) {sections in
                    Section(header: Text(sections.key)) {
                        ForEach(sections.value, id: \.packItemId) {item in
                            PackItemListCell(item: item.packItem)
                        }
                        .onDelete {self.removeGlobalItem(at: $0, items: sections.value )}
                    }
                }
            }
            .refreshable {
                packItemListVm.getAllPackItems()
            }
            .navigationTitle("Items")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        self.showForm = true
                    }
                }
            }
            .onAppear(perform: {
                packItemListVm.getAllPackItems()
            })
            .sheet(isPresented: $showForm,
                   onDismiss: { packItemListVm.getAllPackItems() },
                   content: { PackItemAddScreen() }
            )
        }
    }
    
    private func removeGlobalItem( at indexSet: IndexSet, items: [PackItemVM] ){
        //        print("*** Removing an item")
        if let itemIndex: Int = indexSet.first {
            let itemVMToDelete = items[itemIndex]
            let itemToDelete = itemVMToDelete.packItem
            print(itemToDelete)
            try? itemToDelete.delete()
            packItemListVm.getAllPackItems()
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
            NavigationLink(
                destination: PackItemEditScreen2(editItemVM: PackItemEditVM(packItemIn: item))
                , label: {PackItemRow(packItem: item)}
            )
        }
    }
}

struct PackItemRow: View {
    @ObservedObject var packItem: PackItem
    
    var body: some View {
        HStack {
            Text(packItem.name ?? "")
            Spacer()
            //            Text(packItem.category?.name ?? "No category")
        }
    }
}

//struct PackItemListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PackItemListScreen()
//    }
//}
