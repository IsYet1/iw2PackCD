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
        sortDescriptors: [NSSortDescriptor(keyPath: \PackItem.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<PackItem>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(packItemListVm.packItems, id: \.packItemId) { item in
                    PackItemListCell(item: item.packItem, packItemListVM: packItemListVm)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Pack Items VM")
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
            .onAppear(perform: {
                packItemListVm.getAllPackItems()
            })
            .sheet(isPresented: $showForm,
               onDismiss: { packItemListVm.getAllPackItems() },
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

struct PackItemListCell: View {
    let item: PackItem
    let packItemListVM: PackItemListVM
    var body: some View {
        VStack {
            NavigationLink {
                PackItemEditScreen(packItem: item)
            } label: {
                PackItemRow(packItem: item)
            }
//            .onDisappear(perform: {
//                packItemListVM.getAllPackItems()
//            })
        }
    }
}

struct PackItemRow: View {
    @ObservedObject var packItem: PackItem
    
    var body: some View {
        HStack {
            Text(packItem.name ?? "")
            Spacer()
//            Text(item.categoryName)
        }
    }
}

//struct PackItemListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PackItemListScreen()
//    }
//}
