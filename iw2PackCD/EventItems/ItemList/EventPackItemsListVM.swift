//
//  EventPackItemsListVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 03-Jul-22.
//

import Foundation

// TODO: Move this to a

enum PackPhase {
    case staged
    case packed
}

enum EventItemListToggle {
    case filterToUnpacked
    case byLocation
}

class EventPackItemListVM: ObservableObject {
    @Published var eventItems: [EventItem] = []
    
    @Published var filterItems: Bool = false
    @Published var byLocation: Bool = false
    @Published var groupedSortedFiltered: [(key: String, value: [EventItem] ) ] = []
    @Published var itemCount = 0
    @Published var packedCount = 0
    
    func getEventPackItems(event: Event) {
        getInitialActionToggleSettings()
        eventItems = event.getEventItemsForEvent(event: event)
        groupedSortedFiltered = groupItems(items: eventItems)
        storeEventNameForStartup(eventName: event.name!)
    }
    
    func groupItems(items: [EventItem] ) -> [(key: String, value: [EventItem] ) ]  {
        var orderList: [(key: String, value: [EventItem] ) ] {
            let itemsSorted = items.sorted(by: { $0.item?.name ?? "___ no name" < $1.item?.name ?? "___ no name" })
            let itemsFiltered = !self.filterItems
            ? itemsSorted
            : itemsSorted.filter() {!($0.packed) }
            let listGroup: [String: [EventItem]] = Dictionary(grouping: itemsFiltered, by: { eventItem in
                //                return eventItem.item?.category?.name ?? "___ No Category"
                return byLocation
                ? eventItem.item?.location?.name ?? "___ LOCATION not set"
                : eventItem.item?.category?.name ?? "___ CATEGORY not set"
            })
            return listGroup.sorted(by: {$0.key < $1.key})
        }
        return orderList
    }
    
    func updatePackedStatus(checked: Bool, eventItem: EventItem, phase: PackPhase) {
        switch phase {
        case .staged:
            // If staged is cleared then ensure that packed is cleared also.
            if !checked {
                eventItem.packed = false
            }
            eventItem.staged = checked
        case .packed:
            eventItem.packed = checked
            // If packed is checked then ensure that staged is checked also. Not the inverse, don't clear staged if packed is cleared.
            if checked {
                eventItem.staged = true
            }
        }
        try? eventItem.save()
    }
    
    func updatePackedStatusThenReload(checked: Bool, eventItem: EventItem, phase: PackPhase) {
        updatePackedStatus(checked: checked, eventItem: eventItem, phase: phase)
        getEventPackItems(event: eventItem.event!)
    }
    
    func resetListStatus() {
        guard !eventItems.isEmpty
        else { return }
        
//        print ("Resetting the list")
        eventItems.forEach {self.updatePackedStatus(checked: false, eventItem: $0, phase: .staged) }
        getEventPackItems(event: eventItems[0].event!)
        
    }
    
    func refreshList() {
        getEventPackItems(event: eventItems[0].event!)
    }
    
    func toggle(toggleType: EventItemListToggle, isOn: Bool) {
        guard !eventItems.isEmpty
        else { return }
        
        switch toggleType {
        case .filterToUnpacked:
            filterItems = isOn
            UserDefaults.standard.set(isOn, forKey: "unpackedChecked")
        case .byLocation:
            byLocation = isOn
            UserDefaults.standard.set(isOn, forKey: "locationChecked")
        }
        getEventPackItems(event: eventItems[0].event!)
        
    }
    
    func storeEventNameForStartup(eventName: String) {
        UserDefaults.standard.set(eventName, forKey: "eventNameForStartup")
//        print(UserDefaults.standard.string(forKey: "eventNameForStartup") as? String)
    }
    
    func getInitialActionToggleSettings() {
        filterItems = (UserDefaults.standard.bool(forKey: "unpackedChecked"))
        byLocation = (UserDefaults.standard.bool(forKey: "locationChecked"))
    }
}
