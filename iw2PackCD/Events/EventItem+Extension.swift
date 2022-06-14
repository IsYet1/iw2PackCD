//
//  Category+Extension.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 29-Apr-22.
//

import Foundation
import CoreData

extension EventItem: BaseModel {
    
    func addEventItem(event: Event, item: PackItem) {
        let newEventItem = EventItem(context: EventItem.viewContext)
        newEventItem.event = event
        newEventItem.item = item
        
        newEventItem.packed = false
        newEventItem.qty = 0
        
        try? newEventItem.save()
    }
    
    
}
