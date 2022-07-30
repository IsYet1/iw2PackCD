//
//  EventPackItemsListCell.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 04-Jul-22.
//

// To invoke this view in the EventPackItemsList:
// ForEach(sections.value, id: \.id) {eventItem in
//     EventPackItemsListCell(eventPackItemListVM: eventPackItemListVM, eventItem: eventItem, event: event)
// in place of the HStack that's there now
import SwiftUI
import CoreData

struct EventPackItemsListCell: View {
    @ObservedObject var eventPackItemListVM: EventPackItemListVM
    let eventItem: EventItem
    let event: Event

    var body: some View {
        HStack {
            Toggle(
                "",
                isOn: Binding<Bool> (
                    get: {
                        return eventItem.staged
                    },
                    set: {
                        eventPackItemListVM.updatePackedStatus(checked: $0, eventItem: eventItem, phase: .staged)
                        eventPackItemListVM.getEventPackItems(event: event)
                    }
                )
            )
            .toggleStyle(CheckboxToggleStyle(style: .circle))
            
            Toggle(
                eventItem.item?.name ?? "No name",
                isOn: Binding<Bool> (
                    get: {
                        return eventItem.packed
                    },
                    set: {
                        eventPackItemListVM.updatePackedStatus(checked: $0, eventItem: eventItem, phase: .packed)
                        eventPackItemListVM.getEventPackItems(event: event)
                    }
                )
            )
            .toggleStyle(CheckboxToggleStyle(style: .square))
            .foregroundColor(.blue)
        }
    }
}

//struct EventPackItemsListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        EventPackItemsListCell()
//    }
//}
