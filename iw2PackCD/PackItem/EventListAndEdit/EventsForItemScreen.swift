//
//  EventsForItemScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 8/21/22.
//

import SwiftUI

struct EventsForItemScreen: View {
    @StateObject var editItemVM: PackItemEditVM
    
    var body: some View {
        VStack {
            Text("Add or Remove this Item to Events").font(.headline)
            List {
                ForEach(editItemVM.allEvents, id: \.id) { itemEvent in
                        EventItemAddCell(
                            eventItemEditVM: EventItemEditVM(packItemIn: editItemVM.vmPackItem.packItem, eventIn: itemEvent )
                            , eventItemCellType: .item
                        )
                }
            }
            .refreshable {
                editItemVM.getEventsForItem(packItemIn: editItemVM.vmPackItem.packItem )
            }
            .onAppear(perform: {
                editItemVM.getEventsForItem(packItemIn: editItemVM.vmPackItem.packItem )
            })
        }
    }
}

//struct EventsForItemScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        EventsForItemScreen()
//    }
//}
