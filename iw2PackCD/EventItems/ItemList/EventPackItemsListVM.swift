//
//  EventPackItemsListVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 03-Jul-22.
//

import Foundation

class EventPackItemListVM: ObservableObject {
    @Published var eventPackItemNames: [String]
    var vmEvent: Event

    init (event: Event) {
        eventPackItemNames = event.getPackItemNames(event: event)
        vmEvent = event
    }
    
    func refreshEventPackItemListNames () {
        eventPackItemNames = vmEvent.getPackItemNames(event: vmEvent)
    }
}
