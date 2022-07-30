//
//  EventPackItemsListCell.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 04-Jul-22.
//

import SwiftUI
import CoreData

struct EventPackItemsListActions: View {
    @ObservedObject var eventPackItemListVM: EventPackItemListVM
    let event: Event

    var body: some View {
            HStack (alignment: .center, spacing: 50) {
                Toggle(isOn: Binding<Bool> (
                    get: {
                        return eventPackItemListVM.filterItems
                    },
                    set: {
                        eventPackItemListVM.filterItems = $0
                        eventPackItemListVM.getEventPackItems(event: event)
                    }
                ),
                       label: {Text("Unpacked").font(.footnote)}
                )
                .toggleStyle(CheckboxToggleStyle(style: .circle))

                Toggle(isOn: Binding<Bool> (
                        get: {
                            return eventPackItemListVM.byLocation
                        },
                        set: {
                            eventPackItemListVM.byLocation = $0
                            eventPackItemListVM.getEventPackItems(event: event)
                        }
                       ),
                       label: {Text("Location").font(.footnote)}
                )
                .toggleStyle(CheckboxToggleStyle(style: .circle))

                Button("Reset") {
                    eventPackItemListVM.resetListStatus()
                    eventPackItemListVM.getEventPackItems(event: event)
                }.buttonStyle(.bordered)
            }
            .padding(15)
            .background(Color.gray.opacity(0.3), in: Rectangle())
            .cornerRadius(7)
    }
}

//struct EventPackItemsListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        EventPackItemsListCell()
//    }
//}
