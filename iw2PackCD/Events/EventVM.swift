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
}
