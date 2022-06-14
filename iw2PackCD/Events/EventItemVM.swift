//
//  PackItemViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import Foundation
import CoreData

struct EventItemVM {
    let eventItem: EventItem
    
    var eventItemId: NSManagedObjectID { return eventItem.objectID }
//    var name: String { return event.name ?? "" }
//    var packItem: PackItem { return eventItem.items ?? Event() }
    var event: Event { return eventItem.event ?? Event() }
}
