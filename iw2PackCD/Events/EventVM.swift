//
//  EventVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 26-Jul-22.
//

import Foundation
import CoreData

struct EventVM {
    let event: Event
    
    var eventId: NSManagedObjectID { return event.objectID }
    var name: String { return event.name ?? "" }
    
    var eventItemsNSSet: NSSet { return event.eventItems ?? []}
    var packedItems: Set<AnyHashable> {
        return self.eventItemsNSSet.filtered(using: NSPredicate(
            format: "packed == true"
        ))
    }
    var stagedItems: Set<AnyHashable> {
        return self.eventItemsNSSet.filtered(using: NSPredicate(
            format: "staged == true"
        ))
    }
    var skippedItems: Set<AnyHashable> {
        return self.eventItemsNSSet.filtered(using: NSPredicate(
            format: "skipped == true"
        ))
    }
    
    var countTotal: Int { return event.eventItems?.count ?? 0 }
    var countPacked: Int { return self.packedItems.count }
    var countStaged: Int { return self.stagedItems.count }
    var countSkipped: Int { return self.skippedItems.count }

}
