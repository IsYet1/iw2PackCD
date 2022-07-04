//
//  Category+Extension.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 29-Apr-22.
//

import Foundation
import CoreData

extension Event: BaseModel {
    func getEventPackItemsCount (event: Event) -> Int {
        let eventItemRecords = event.eventItems
        let count = eventItemRecords?.count ?? 0
        return count
    }
    
    func getPackItems(event: Event) -> [PackItem] {
        // TODO: Streamline this.
        guard let eventItemSet = event.eventItems,
              let eventItemAry = eventItemSet.allObjects as? [EventItem]
        else { return [] }
        let eventItems = EventItem.mapEventItem_PackItems(eventItems: eventItemAry)
        return getEventPackItemsCount(event: event) == 0
        ? []
        : eventItems
    }
    
    func getPackItemNames(event: Event) -> [String] {
        // TODO: Streamline this.
        guard let eventItemSet = event.eventItems,
              let eventItemAry = eventItemSet.allObjects as? [EventItem]
        else { return ["No Event Items"] }
        let mappedNames = EventItem.mapEventItem_PackItemNames(eventItems: eventItemAry)
        return getEventPackItemsCount(event: event) == 0
        ? ["None"]
        : mappedNames
    }
    
    
    
}
