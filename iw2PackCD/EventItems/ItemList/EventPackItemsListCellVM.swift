//
//  EventPackItemsListCellVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 04-Jul-22.
//

import Foundation
import CoreData

class EventItemListCellVM: ObservableObject {
    let eventItem: EventItem
    var packItemName: String
    
    @Published var itemPacked: Bool
    
    init(eventItemIn: EventItem) {
        eventItem = eventItemIn
        itemPacked = eventItemIn.packed
        
        // TODO: Add error check and handle here.
        packItemName = eventItemIn.item!.name!
    }
    
    func updatePackedStatus(packed: Bool) {
        // TODO: Add error check and handle here.
        itemPacked = packed
        eventItem.packed = packed
        try? eventItem.save()
    }
}
