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
    case filterSkipped
    case byLocation
}

class EventPackItemListVM: ObservableObject {
    @Published var eventItems: [EventItem] = []
    @Published var curEvent: EventVM?
    
    @Published var hidePacked: Bool = false
    @Published var hideStaged: Bool = false
    @Published var hideSkipped: Bool = false
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
            let itemsFiltered =
                self.hidePacked ? itemsSorted.filter() {!($0.packed) || (!hideSkipped && $0.skipped) }
                : self.hideStaged ? itemsSorted.filter() {!($0.staged) || (!hideSkipped && $0.skipped) }
                : self.hideSkipped ? itemsSorted.filter() {!($0.skipped) }
                : itemsSorted
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
    
    func removeSelectedEventItem(eventItem: EventItem) {
        let packItem = eventItem.item
        let event = eventItem.event
        EventItem.deletePackItemFromEvent(event: event!, packItem: packItem! )
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
            hidePacked = isOn
            if isOn {hideStaged = false}
        case .filterToUnstaged:
            hideStaged = isOn
            if isOn {hidePacked = false}
        case .filterSkipped:
            hideSkipped = isOn
        case .byLocation:
            byLocation = isOn
            UserDefaults.standard.set(isOn, forKey: "locationChecked")
        }
        
//        if (!filterItems && !filterStaged) {hideSkipped = false}
        
        UserDefaults.standard.set(hidePacked, forKey: "unpackedChecked")
        UserDefaults.standard.set(hideSkipped, forKey: "skippedChecked")
        UserDefaults.standard.set(hideStaged, forKey: "unStagedChecked")
        
        getEventPackItems()
        
    }
    
    func storeEventNameForStartup(eventName: String) {
        UserDefaults.standard.set(eventName, forKey: "eventNameForStartup")
//        print(UserDefaults.standard.string(forKey: "eventNameForStartup") as? String)
    }
    
    func getInitialActionToggleSettings() {
        hidePacked = (UserDefaults.standard.bool(forKey: "unpackedChecked"))
        hideStaged = (UserDefaults.standard.bool(forKey: "unStagedChecked"))
        hideSkipped = (UserDefaults.standard.bool(forKey: "skippedChecked"))
        byLocation = (UserDefaults.standard.bool(forKey: "locationChecked"))
    }
}
