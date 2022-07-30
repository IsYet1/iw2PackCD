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

    var body: some View {
            HStack (alignment: .center, spacing: 50) {
                Toggle(isOn: Binding<Bool> (
                    get: {
                        return eventPackItemListVM.filterItems
                    },
                    set: {
                        eventPackItemListVM.toggle(toggleType: .filterToUnpacked, isOn: $0)
                    }
                ),
                       label: {Text("Unpacked").font(.footnote)}
                )
                .toggleStyle(CheckboxToggleStyle(style: .circle))
                .disabled(eventPackItemListVM.eventItems.isEmpty)

                Toggle(isOn: Binding<Bool> (
                        get: {
                            return eventPackItemListVM.byLocation
                        },
                        set: {
                            eventPackItemListVM.toggle(toggleType: .byLocation, isOn: $0)
                        }
                       ),
                       label: {Text("Location").font(.footnote)}
                )
                .toggleStyle(CheckboxToggleStyle(style: .circle))
                .disabled(eventPackItemListVM.eventItems.isEmpty)

                Button("Reset") {
                    eventPackItemListVM.resetListStatus()
                }
                .disabled(eventPackItemListVM.eventItems.isEmpty)
                .buttonStyle(.bordered)
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
