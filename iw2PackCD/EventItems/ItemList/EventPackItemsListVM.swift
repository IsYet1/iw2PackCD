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
    case skipped
}

enum EventItemListToggle {
    case filterToUnpacked
    case filterToUnstaged
    case byLocation
}

class EventPackItemListVM: ObservableObject {
    @Published var eventItems: [EventItem] = []
    @Published var curEvent: EventVM?
    
    @Published var filterItems: Bool = false
    @Published var filterStaged: Bool = false
    @Published var byLocation: Bool = false
    @Published var groupedSortedFiltered: [(key: String, value: [EventItem] ) ] = []
    @Published var countTotal = 0
    @Published var countPacked = 0
    @Published var countStaged = 0
    @Published var countSkipped = 0
    
    func initEventPackItemListVM (eventName: String) {
        let tmpEvent = Event.getEventByName(eventName: eventName)
        guard tmpEvent.count > 0 else {
            print("Event not found: ", eventName)
            return
        }
        self.curEvent = EventVM(event: tmpEvent.first!)
        storeEventNameForStartup(eventName: eventName)
        getInitialActionToggleSettings()
        getEventPackItems()
    }
    
    func getEventPackItems() {
        guard curEvent != nil else {
            print("Current Event Not Set")
            return
        }
        eventItems = curEvent!.event.getEventItemsForEvent(event: curEvent!.event)
        countTotal = curEvent!.countTotal
        countPacked = curEvent!.countPacked
        countStaged = curEvent!.countStaged
        countSkipped = curEvent!.countSkipped
        groupedSortedFiltered = groupItems(items: eventItems)
    }
    
    func groupItems(items: [EventItem] ) -> [(key: String, value: [EventItem] ) ]  {
        var orderList: [(key: String, value: [EventItem] ) ] {
            let itemsSorted = items.sorted(by: { $0.item?.name ?? "___ no name" < $1.item?.name ?? "___ no name" })
            let itemsFiltered = !self.filterItems
            ? itemsSorted
            : itemsSorted.filter() {!($0.packed) || $0.skipped }
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
                eventItem.skipped = false
            }
            eventItem.staged = checked
        case .packed:
            eventItem.packed = checked
            // If packed is checked then ensure that staged is checked also. Not the inverse, don't clear staged if packed is cleared.
            if checked {
                eventItem.staged = true
            } else if eventItem.skipped {
                eventItem.skipped = false
            }
        case .skipped:
            eventItem.skipped = true
            eventItem.packed = true
            eventItem.staged = true
        }
        try? eventItem.save()
    }
    
    func updatePackedStatusThenReload(checked: Bool, eventItem: EventItem, phase: PackPhase) {
        updatePackedStatus(checked: checked, eventItem: eventItem, phase: phase)
        getEventPackItems()
    }
    
    func resetListStatus() {
        guard !eventItems.isEmpty
        else { return }
        
//        print ("Resetting the list")
        eventItems.forEach {self.updatePackedStatus(checked: false, eventItem: $0, phase: .staged) }
        getEventPackItems()
        
    }
    
    func refreshList() {
        getEventPackItems()
    }
    
    func toggle(toggleType: EventItemListToggle, isOn: Bool) {
        guard !eventItems.isEmpty
        else { return }
        
        switch toggleType {
        case .filterToUnpacked:
            filterItems = isOn
            UserDefaults.standard.set(isOn, forKey: "unpackedChecked")
        case .filterToUnstaged:
            filterStaged = isOn
            UserDefaults.standard.set(isOn, forKey: "unStagedChecked")
        case .byLocation:
            byLocation = isOn
            UserDefaults.standard.set(isOn, forKey: "locationChecked")
        }
        getEventPackItems()
        
    }
    
    func storeEventNameForStartup(eventName: String) {
        UserDefaults.standard.set(eventName, forKey: "eventNameForStartup")
//        print(UserDefaults.standard.string(forKey: "eventNameForStartup") as? String)
    }
    
    func getInitialActionToggleSettings() {
        filterItems = (UserDefaults.standard.bool(forKey: "unpackedChecked"))
        filterStaged = (UserDefaults.standard.bool(forKey: "unStagedChecked"))
        byLocation = (UserDefaults.standard.bool(forKey: "locationChecked"))
    }
}
