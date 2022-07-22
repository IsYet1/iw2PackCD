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
    @Published var itemStaged: Bool
    
    init(eventItemIn: EventItem) {
        eventItem = eventItemIn
        itemPacked = eventItemIn.staged
        itemStaged = eventItemIn.staged
        
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
    
    func updatePackedStatus(checked: Bool, phase: PackPhase) {
        // TODO: Add error check and handle here.
        switch phase {
        case .staged:
            // If staged is cleared then ensure that packed is cleared also. 
            if !checked {
                itemPacked = checked
                eventItem.packed = checked
            }
            itemStaged = checked
            eventItem.staged = checked
        case .packed:
            itemPacked = checked
            eventItem.packed = checked
            // If packed is checked then ensure that staged is checked also. Not the inverse, don't clear staged if packed is cleared.
            if checked {
                itemStaged = checked
                eventItem.staged = checked
            }
        }
        try? eventItem.save()
    }
}
