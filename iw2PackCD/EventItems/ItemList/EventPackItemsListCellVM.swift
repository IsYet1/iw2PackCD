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
    var packItemCategory: String
    
    @Published var itemPacked: Bool
    
    init(eventItemIn: EventItem) {
        eventItem = eventItemIn
        itemPacked = eventItemIn.packed
        
        // TODO: Add error check and handle here.
        if let itemIn = eventItemIn.item {
            packItemName = itemIn.name ?? "Item name not set"
            packItemCategory = itemIn.categoryName
        } else {
            packItemName = "Item Not Found"
            packItemCategory = "Item Not Found"
        }
//        packItemName = eventItemIn.item?.name ?? "Item Not Found"
//        packItemCategory = eventItemIn.item!.categoryName
    }
    
    func updatePackedStatus(packed: Bool) {
        // TODO: Add error check and handle here.
        itemPacked = packed
        eventItem.packed = packed
        try? eventItem.save()
    }
}