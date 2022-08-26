//
//  EventPackItemsListCell.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 04-Jul-22.
//

import SwiftUI
import CoreData

struct EventPackItemsListCell: View {
    @ObservedObject var eventPackItemListVM: EventPackItemListVM
    let eventItem: EventItem

    var body: some View {
        /*
         */
        HStack {
            Toggle(
                "",
                isOn: Binding<Bool> (
                    get: {
                        return eventItem.staged
                    },
                    set: {
                        eventPackItemListVM.updatePackedStatusThenReload(checked: $0, eventItem: eventItem, phase: .staged)
                    }
                )
            )
            .toggleStyle(CheckboxToggleStyle(style: .circle))
            
            Toggle(
//                eventItem.item?.name ?? "No name",
                "",
                isOn: Binding<Bool> (
                    get: {
                        return eventItem.packed
                    },
                    set: {
                        eventPackItemListVM.updatePackedStatusThenReload(checked: $0, eventItem: eventItem, phase: .packed)
                    }
                )
            )
            .toggleStyle(CheckboxToggleStyle(style: .square))
            .foregroundColor(eventItem.skipped ? .gray : .blue)
            
            Text(eventItem.item?.name ?? "No name")
                .fontWeight(eventItem.skipped ? .ultraLight : .regular)
                .strikethrough(eventItem.skipped)
                // TODO: Remove this
//                .onLongPressGesture(minimumDuration: 1, maximumDistance: 10, perform: {
//                eventPackItemListVM.updatePackedStatusThenReload(checked: true, eventItem: eventItem, phase: .skipped)
//            } )
        }
    }
}

//struct EventPackItemsListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        EventPackItemsListCell()
//    }
//}
