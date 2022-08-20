//
//  PackItem+Extension.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import Foundation
import CoreData

extension PackItem: BaseModel {
    
    var packItemName: String {
        return name ?? "Not Set"
    }
    
    var packItemCategory: Category {
        return category ?? Category(context: Category.viewContext)
    }
    
    var categoryName: String {
        return category?.name ?? "Not Set"
    }
    
    static func addPackItem(name: String, category: Category, location: Location) {
        let addedPackItem = PackItem(context: PackItem.viewContext)
        addedPackItem.name = name
        addedPackItem.category = category
        addedPackItem.location = location
        
        try? addedPackItem.save()
    }
    
    static func updatePackItem(packItem: PackItem, name: String) {
        packItem.setValue(name, forKey: "packItemName")
        try? packItem.save()
    }
    
    static func mapPackItemNames (packItems: [PackItem]) -> [String] {
        let names = packItems.compactMap({packItem in
            return packItem.name
        })
        return names
    }
    
    func getPackItemsEventCount (packItem: PackItem) -> Int {
        let eventItemRecords = packItem.events
        let count = eventItemRecords?.count ?? 0
        return count
    }
    
    func getEventsForPackItem(packItem: PackItem) -> [Event] {
        // TODO: Streamline this.
        guard let eventItemSet = packItem.events,
              let eventItemAry = eventItemSet.allObjects as? [EventItem]
        else { return [] }
        let mappedNames = EventItem.mapEventItem_Events(eventItems: eventItemAry)
        return getPackItemsEventCount(packItem: packItem) == 0
        ? []
        : mappedNames
        
//        return ["Found some items"]
    }
    
    func getEventNamesForPackItem(packItem: PackItem) -> [String] {
        // TODO: Streamline this.
        guard let eventItemSet = packItem.events,
              let eventItemAry = eventItemSet.allObjects as? [EventItem]
        else { return ["No Event Items"] }
        let mappedNames = EventItem.mapEventItem_EventNames(eventItems: eventItemAry)
        return getPackItemsEventCount(packItem: packItem) == 0
        ? ["None"]
        : mappedNames
        
//        return ["Found some items"]
    }
    
    func getEventIdsForPackItem(packItem: PackItem) -> [ObjectIdentifier] {
        // TODO: Streamline this.
        guard let eventItemSet = packItem.events,
              let eventItemAry = eventItemSet.allObjects as? [EventItem]
        else { return [] }
        let mappedIds = EventItem.mapEventItem_EventIds(eventItems: eventItemAry)
        return getPackItemsEventCount(packItem: packItem) == 0
        ? []
        : mappedIds
        
//        return ["Found some items"]
    }
 }
