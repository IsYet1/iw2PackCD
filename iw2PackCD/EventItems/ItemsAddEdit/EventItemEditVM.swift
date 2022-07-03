//
//  PackItemEditVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 22-May-22.
//

import Foundation
import CoreData

class EventItemEditVM: ObservableObject {
    let packItem: PackItem
    let event: Event
    @Published var itemIsInEvent: Bool
    @Published var eventItem: EventItem?

    init(packItemIn: PackItem, eventIn: Event) {
        eventItem = EventItem.findPackItemFromEvent(event: eventIn, packItem: packItemIn)
        packItem = packItemIn
        event = eventIn
        
        itemIsInEvent = EventItem.findItemEvent(event: eventIn, packItem: packItemIn)!.count > 0
    }
    
    func addOrRemoveItemToEvent(addItem: Bool) {
        // TODO: Add error checking here and don't change checkbox if there's an error.
        if (addItem) {
            EventItem.addEventItem(event: event, item: packItem)
        } else {
            EventItem.deletePackItemFromEvent(event: event, packItem: packItem )
        }
        itemIsInEvent = addItem
    }
    
}

struct EventItem_AddEdit {
    var packItem: PackItem
    var event: Event
}


