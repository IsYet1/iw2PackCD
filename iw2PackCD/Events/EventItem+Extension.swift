//
//  Category+Extension.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 29-Apr-22.
//

import Foundation
import CoreData

extension EventItem: BaseModel {
    
    static func addEventItem(event: Event, item: PackItem) {
        let newEventItem = EventItem(context: EventItem.viewContext)
        newEventItem.event = event
        newEventItem.item = item
        
        newEventItem.packed = false
        newEventItem.qty = 0
        
        try? newEventItem.save()
    }
   
    
    static func mapEventItem_PackItemNames (eventItems: [EventItem]) -> [String] {
        let names = eventItems.compactMap({eventItem in
            return eventItem.item?.name
        })
        return names
    }
    
    static func mapEventItem_EventNames (eventItems: [EventItem]) -> [String] {
        let names = eventItems.compactMap({eventItem in
            return eventItem.event?.name
        })
        return names
    }
    
    static func mapEventItem_EventIds (eventItems: [EventItem]) -> [ObjectIdentifier] {
        let ids = eventItems.compactMap({eventItem in
            return eventItem.event?.id
        })
        return ids
    }
}
