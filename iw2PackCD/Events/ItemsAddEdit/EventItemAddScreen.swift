//
//  PackItemFormScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import SwiftUI

struct EventItemAddScreen: View {
    let event: Event
    
    @StateObject private var packItemListVm = PackItemListVM()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PackItem.name, ascending: false)],
        animation: .default)
    private var items: FetchedResults<PackItem>
    
    @State private var addedPackItems: [PackItem] = []
    
    var body: some View {
        VStack {
            CloseButton()
            Divider()
            Text("Add Items To: \(event.name!)").font(.title)
            Divider()
            List {
                ForEach(packItemListVm.packItems, id: \.packItemId) { item in
                    EventItemAddCell(packItem: item.packItem, event: event)
                }
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


