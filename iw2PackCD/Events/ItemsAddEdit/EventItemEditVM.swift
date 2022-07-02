//
//  PackItemEditVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 22-May-22.
//

import Foundation
import CoreData

class EventItemEditVM: ObservableObject {
//    let packItem: PackItem?
//    let event: Event?
//    @Published var vmName: String
    @Published var eventItem: EventItem?

    init(packItemIn: PackItem, eventIn: Event) {
        eventItem = EventItem.findPackItemFromEvent(event: eventIn, packItem: packItemIn)
    }
    
}


