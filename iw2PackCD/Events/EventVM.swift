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
    var countTotal: Int { return event.eventItems?.count ?? 0 }
    var countPacked: Int {
        let thisEventItems = NSSet(set: event.eventItems!)
        let packedItems = thisEventItems.filtered(using: NSPredicate(
            format: "packed == true"
        ))
        return packedItems.count // ?? 0
//        return 0
    }
    var countStaged: Int {
        let thisEventItems = NSSet(set: event.eventItems!)
        let stagedItems = thisEventItems.filtered(using: NSPredicate(
            format: "staged == true"
        ))
        return stagedItems.count // ?? 0
//        return 0
    }

}
