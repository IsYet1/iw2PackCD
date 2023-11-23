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
            .toggleStyle(CheckboxToggleStyle(style: .circle, markType: .checkmark))
            
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
            .toggleStyle(CheckboxToggleStyle(style: .square, markType: .checkmark))
            .foregroundColor(eventItem.skipped ? .gray : .blue)
            
            VStack(alignment: .leading) {
                Text(eventItem.item?.name ?? "No name")
                    .fontWeight(eventItem.skipped ? .ultraLight : .regular)
                .strikethrough(eventItem.skipped)
                
                Text(eventPackItemListVM.byLocation ? (eventItem.item?.categoryName ?? "") : (eventItem.item?.location?.name ?? "") )
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
            }
        }
    }
}

//struct EventPackItemsListCell_Previews: PreviewProvider {
//        let packItem = PackItem(context: PersistenceController.shared.container.viewContext)
//        packItem.name = "Test Item"
//    static var previews: some View {
//        let eventPackItemListVM: EventPackItemListVM = EventPackItemListVM()
//        let eventItem = EventItem(context: PersistenceController.shared.container.viewContext)
//
//        EventPackItemsListCell(eventPackItemListVM: eventPackItemListVM , eventItem: eventItem)
//    }
//}
