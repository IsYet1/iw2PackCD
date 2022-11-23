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
    @State private var confirmReset = false

    var body: some View {
            HStack (alignment: .center, spacing: 15) {
                Toggle(isOn: Binding<Bool> (
                    get: {
                        return eventPackItemListVM.filterStaged
                    },
                    set: {
                        eventPackItemListVM.toggle(toggleType: .filterToUnstaged, isOn: $0)
                    }
                ),
                       label: {Text("Staged").font(.footnote)}
                )
                .toggleStyle(CheckboxToggleStyle(style: .circle))
                .disabled(eventPackItemListVM.eventItems.isEmpty)

                Toggle(isOn: Binding<Bool> (
                    get: {
                        return eventPackItemListVM.filterItems
                    },
                    set: {
                        eventPackItemListVM.toggle(toggleType: .filterToUnpacked, isOn: $0)
                    }
                ),
                       label: {Text("Packed").font(.footnote)}
                )
                .toggleStyle(CheckboxToggleStyle(style: .circle))
                .disabled(eventPackItemListVM.eventItems.isEmpty)

                Toggle(isOn: Binding<Bool> (
                    get: {
                        return eventPackItemListVM.hideSkipped
                    },
                    set: {
                        eventPackItemListVM.toggle(toggleType: .filterSkipped, isOn: $0)
                    }
                ),
                       label: {Text("Skipped").font(.footnote)}
                )
                .toggleStyle(CheckboxToggleStyle(style: .diamond))
                .disabled(
                    eventPackItemListVM.eventItems.isEmpty
                    || (!eventPackItemListVM.filterItems && !eventPackItemListVM.filterStaged)
                )

                Spacer()
                
                Toggle(isOn: Binding<Bool> (
                        get: {
                            return eventPackItemListVM.byLocation
                        },
                        set: {
                            eventPackItemListVM.toggle(toggleType: .byLocation, isOn: $0)
                        }
                       ),
                       label: {Text("Location").font(.caption)}
                )
                .toggleStyle(CheckboxToggleStyle(style: .square))
                .disabled(eventPackItemListVM.eventItems.isEmpty)
                Spacer()

                Button("Reset") {
                    confirmReset = true
                }
                .disabled(
                    eventPackItemListVM.eventItems.isEmpty
                    || (eventPackItemListVM.countPacked + eventPackItemListVM.countStaged == 0)
                )
                .buttonStyle(.bordered)
            }
            .padding(10.0)
            .background(Color.gray.opacity(0.3), in: Rectangle())
            .cornerRadius(7)
            .alert(
                "Confirm Reset",
                isPresented: $confirmReset,
                actions: {
                    Button("Yes", role: .destructive , action: {
                        confirmReset = false
                        eventPackItemListVM.resetListStatus()
                    })
                    Button("No", role: .cancel, action: {confirmReset = false})
                }
                , message: { Text("Reset this list?") }
            )
    }
}

//struct EventPackItemsListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        EventPackItemsListCell()
//    }
//}
