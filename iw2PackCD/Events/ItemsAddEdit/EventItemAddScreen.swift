//
//  PackItemFormScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import SwiftUI

struct EventItemAddScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var packItemListVm = PackItemListVM()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PackItem.name, ascending: false)],
        animation: .default)
    private var items: FetchedResults<PackItem>
    
    @State private var packItemName = ""
    
    var body: some View {
        VStack {
            Text("Add an Item To This Event").font(.title)
            List {
                ForEach(packItemListVm.packItems, id: \.packItemId) { item in
                    EventItemListCell(item: item.packItem)
                }
            }
            TextField("Pack Item Name", text: $packItemName)
                .padding([.leading, .trailing], 20.0)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Button("Save") {
//                    PackItem.addPackItem(name: packItemName, category: selectedCategory!)
                    presentationMode.wrappedValue.dismiss()
                }.padding()
                .buttonStyle(.bordered)
            }
        }
        Spacer()
    }
}

struct EventItemListCell: View {
    let item: PackItem
    
    var body: some View {
        VStack {
            NavigationLink(
                destination: PackItemEditScreen2(editItemVM: PackItemEditVM(packItemIn: item))
                , label: {EventItemRow(packItem: item)}
            )
        }
    }
}

struct EventItemRow: View {
    @ObservedObject var packItem: PackItem
    
    var body: some View {
        HStack {
            Text(packItem.name ?? "")
            Spacer()
            Text(packItem.category?.name ?? "No category")
        }
    }
}
//struct PackItemFormScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PackItemAddScreen()
//    }
//}

