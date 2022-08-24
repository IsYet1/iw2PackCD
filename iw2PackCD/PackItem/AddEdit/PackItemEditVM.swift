//
//  PackItemEditVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 22-May-22.
//

import Foundation
import CoreData

class ItemEvent {
    var id = UUID()
    var eventName: String = ""
    var itemIsInEvent: Bool = false
}

class PackItemEditVM: ObservableObject {
    var vmPackItem: PackItemVM
    @Published var vmName: String
    @Published var vmCategory: Category?
    @Published var vmLocation: Location?
    
    @Published var itemEvents: [Event]
    @Published var allEvents: [Event]
    @Published var allItemEvents: [ItemEvent] = []
    
    var metaDataIsInvalid: Bool {
        get {
            return vmCategory == nil || vmLocation == nil
        }
    }
    
    init(packItemIn: PackItem) {
        vmPackItem = PackItemVM(packItem: packItemIn)
        vmName = vmPackItem.name
        vmCategory = vmPackItem.categoryIsSet ? vmPackItem.category : nil
        vmLocation = vmPackItem.locationIsSet ? vmPackItem.location : nil
        
        itemEvents = vmPackItem.packItem.getEventsForPackItem(packItem: vmPackItem.packItem)
        allEvents = Event.all()
        // TODO: I don't think this is used anymore. Remove it.
        allItemEvents = allEvents.map({event in
            let itemIsInEvent = itemEvents.contains(where: {itemEvent in
                return event.id == itemEvent.id
            })
            let rtn: ItemEvent = ItemEvent()
            rtn.eventName = event.name ?? ""
            rtn.itemIsInEvent = itemIsInEvent
            return rtn
        })
    }
    
    func getEventsForItem(packItemIn: PackItem) {
        itemEvents = vmPackItem.packItem.getEventsForPackItem(packItem: vmPackItem.packItem)
        allEvents = Event.all()
    }
    
    func getItemEvents(packItemIn: PackItem) {
    }
        
    func save() {
        vmPackItem.packItem.name = vmName
        vmPackItem.packItem.category = vmCategory
        vmPackItem.packItem.location = vmLocation
        
        try? vmPackItem.packItem.save()
    }
    
}
