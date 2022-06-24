//
//  EventItemAddCell.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 24-Jun-22.
//

import SwiftUI

struct EventItemAddCell: View {
    var packItem: PackItem
    var event: Event
    
    var body: some View {
        var selected: Bool = false
        HStack {
            Toggle(
                packItem.name!,
                isOn: Binding<Bool> (
                    get: {
                        var eventHasPackItem = false;
                        let packItemEvents = packItem.events
                        var packItemEventsCount = packItem.events?.count
                        if let packItemEvents = packItemEvents {
                            packItemEvents.forEach({itemEvent in
                                let eventItem = (itemEvent as! EventItem)
                                let eventItemEvent = eventItem.event
                                eventHasPackItem = eventItemEvent == event
                                var eventPackItemName = eventItemEvent?.name
                                print(eventPackItemName)
//                                var itemEventEvent as Event = itemEvent.event
//                                if (itemEvent.event == event) { eventHasPackItem = true }
//                                else { eventHasPackItem = false }
                            })
                        }
//                        return (packItem.events?.contains(event))!
                        return eventHasPackItem
                    },
                    set: {
                        selected = $0
                        EventItem.addEventItem(event: event, item: packItem)
                    }
                )
            )
            .toggleStyle(CheckboxToggleStyle(style: .circle))
//            .foregroundColor(.blue)
        }
    }
}

//struct EventItemAddCell_Previews: PreviewProvider {
//    static var previews: some View {
//        EventItemAddCell()
//    }
//}
