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
    var packItem: PackItem { return eventItem.item ?? PackItem() }
    var event: Event { return eventItem.event ?? Event() }
    var packed: Bool { return eventItem.packed }
    var staged: Bool { return eventItem.staged }
}
