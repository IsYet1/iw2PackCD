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
            Text("This Item is in in \(editItemVM.itemEvents.count) Events").font(.title)
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
        }
    }
}

//struct EventsForItemScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        EventsForItemScreen()
//    }
//}
