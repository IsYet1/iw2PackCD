//
//  EventPackItemsListVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 03-Jul-22.
//

import Foundation

class EventPackItemListVM: ObservableObject {
    @Published var eventPackItems: [PackItem]
    var vmEvent: Event

    init (event: Event) {
        eventPackItems = event.getPackItems(event: event)
        vmEvent = event
    }
    
    func refreshEventPackItemList () {
        eventPackItems = vmEvent.getPackItems(event: vmEvent)
    }
}
