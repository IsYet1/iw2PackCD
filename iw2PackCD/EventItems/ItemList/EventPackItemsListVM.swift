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
    
    // NOTE: These properties aren't being used as of Mon 11-Jul
    @Published var filterItems: Bool = true
    @Published var groupedSortedFiltered: [(key: String, value: [EventItem] ) ] = []

//    init (event: Event) {
//        eventItems = event.getEventItemsForEvent(event: event)
//        eventPackItems = event.getPackItems(event: event)
//        vmEvent = event
//    }
    
    func getEventPackItems(event: Event) {
//        vmEvent = event
        eventItems = event.getEventItemsForEvent(event: event)
        eventPackItems = event.getPackItems(event: event)
        
        groupedSortedFiltered = groupItems(items: eventItems, filterItems: self.filterItems)
    }
    
    func refreshEventPackItemList () {
//        eventItems = vmEvent!.getEventItemsForEvent(event: vmEvent!)
//        eventPackItems = vmEvent!.getPackItems(event: vmEvent!)
    }
    
    func groupItems(items: [EventItem], filterItems: Bool = false) -> [(key: String, value: [EventItem] ) ]  {
        var orderList: [(key: String, value: [EventItem] ) ] {
            let itemsSorted = items.sorted(by: { $0.item?.name ?? "___ no name" < $1.item?.name ?? "___ no name" })
            let itemsFiltered = !filterItems
            ? itemsSorted
            : itemsSorted.filter() {!($0.packed) }
            let listGroup: [String: [EventItem]] = Dictionary(grouping: itemsFiltered, by: { eventItem in
                return eventItem.item?.category?.name ?? "___ No Category"
                //            return false //byLocation
                //            ? packItem.location ?? "___ LOCATION not set"
                //            : packItem.category ?? "___ CATEGORY not set"
            })
            return listGroup.sorted(by: {$0.key < $1.key})
        }
        return orderList
    }
    
    
}
