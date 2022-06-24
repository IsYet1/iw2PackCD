//
//  PackItemFormScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import SwiftUI

struct EventItemAddScreen: View {
    let event: Event
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var packItemListVm = PackItemListVM()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PackItem.name, ascending: false)],
        animation: .default)
    private var items: FetchedResults<PackItem>
    
    @State private var packItemName = ""
    
    var body: some View {
        VStack {
            Text("Add Items To: \(event.name!)").font(.title)
            Divider()
            List {
                ForEach(packItemListVm.packItems, id: \.packItemId) { item in
                    EventItemAddCell(packItem: item.packItem)
                }
            }
            HStack {
                Button("Add Item To Event") {
                    EventItem.addEventItem(event: event, item: packItemListVm.firstPackItem!.packItem)
                    presentationMode.wrappedValue.dismiss()
                }.padding()
                .buttonStyle(.bordered)
            }
        }
            .onAppear(perform: {
                packItemListVm.getAllPackItems()
            })
        Spacer()
    }
}

//struct PackItemFormScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PackItemAddScreen()
//    }
//}

