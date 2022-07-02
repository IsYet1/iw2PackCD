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
    
    static func findPackItemFromEvent(event: Event, packItem: PackItem) -> EventItem? {
        // TODO: Convert this to NSFetch, etc..
        guard let eventItemSet = event.eventItems,
              let eventItemAry = eventItemSet.allObjects as? [EventItem]
        else {
            print("Guard failed at line 50")
            return nil
        }
        return eventItemAry[0]
        
//        let foundEventItem = eventItemAry.first(where: {$0.item.id == packItem.id})
        
        return nil
    }
    
    static func deletePackItemFromEvent(event: Event, packItem: PackItem) {
        // TODO: Convert this to NSFetch, etc..
        guard let eventItemAry = findItemEvent(event: event, packItem: packItem),
              eventItemAry.count > 0
        else {
            print("Guard failed deletePackItemFromEvent")
            return
        }
        try? eventItemAry[0].delete()
    }
    
    static func findItemEvent(event: Event, packItem: PackItem) -> [EventItem]? {
        let request: NSFetchRequest<EventItem> = EventItem.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@ and %K = %@",
                                        #keyPath(EventItem.event), event,
                                        #keyPath(EventItem.item), packItem
        )
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
    }
    
}
