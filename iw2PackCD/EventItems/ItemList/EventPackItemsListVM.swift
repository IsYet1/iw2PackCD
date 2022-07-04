//
//  EventPackItemsListVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 03-Jul-22.
//

import Foundation

class EventPackItemListVM: ObservableObject {
//    var vmEvent: Event
    
    @Published var eventPackItems: [PackItem] = []
    @Published var eventItems: [EventItem] = []

//    init (event: Event) {
//        eventItems = event.getEventItemsForEvent(event: event)
//        eventPackItems = event.getPackItems(event: event)
//        vmEvent = event
//    }
    
    func getEventPackItems(event: Event) {
//        vmEvent = event
        eventItems = event.getEventItemsForEvent(event: event)
        eventPackItems = event.getPackItems(event: event)
    }
    
    func refreshEventPackItemList () {
//        eventItems = vmEvent!.getEventItemsForEvent(event: vmEvent!)
//        eventPackItems = vmEvent!.getPackItems(event: vmEvent!)
    }
    
}
