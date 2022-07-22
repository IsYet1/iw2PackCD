//
//  CategoryPackItemsList.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 15-May-22.
//

import SwiftUI

struct EventPackItemsList: View {
    
    let event: Event
    @StateObject private var eventPackItemListVM = EventPackItemListVM()
    @State private var showEditEventItemList: Bool = false
    
    @State private var byLocation: Bool = false
    
    var body: some View {
        let itemsCount = event.eventItems?.count ?? 0
        
        VStack {
            Text("\(event.name! )").font(.title)
            Text("\(itemsCount) items").font(.footnote)
            
            List {
                ForEach(eventPackItemListVM.groupedSortedFiltered, id:\.key) {sections in
                    Section(header: Text(sections.key)) {
                        ForEach(sections.value, id: \.id) {eventItem in
                            
                            
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
//                                            eventItemListCellVM.updatePackedStatus(checked: $0, phase: .staged)
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
//                                            eventItemListCellVM.updatePackedStatus(checked: $0, phase: .packed)
                                        }
                                    )
                                )
                                .toggleStyle(CheckboxToggleStyle(style: .square))
                                .foregroundColor(.blue)
                            }
                            
//                            Toggle(
//                                eventItem.item?.name ?? "No name",
//                                isOn: Binding<Bool> (
//                                    get: {
//                                        return eventItem.packed
//                                    },
//                                    set: {
//                                        eventPackItemListVM.updatePackedStatus(checked: $0, eventItem: eventItem)
//                                        eventPackItemListVM.getEventPackItems(event: event)
//                                    }
//                                )
//                            )
                            .toggleStyle(CheckboxToggleStyle(style: .square))
                            .foregroundColor(.blue)
                            //                            EventPackItemsListCell(eventItemListCellVM: EventItemListCellVM(eventItemIn: eventItem))
                        }
                    }
                }
            }
            .refreshable(action: {
                eventPackItemListVM.getEventPackItems(event: event)
            })
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit Item List For This Event") {
                    self.showEditEventItemList = true
                }
            }
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Toggle("Unpacked",
                           isOn: Binding<Bool> (
                            get: {
                                return eventPackItemListVM.filterItems
                            },
                            set: {
                                eventPackItemListVM.filterItems = $0
                                eventPackItemListVM.getEventPackItems(event: event)
                            }
                           )
                    )
                    .toggleStyle(.switch)
                    .frame(width: 150)
                    .padding([.trailing], 20)
                    
                    Toggle("Location",
                           isOn: Binding<Bool> (
                            get: {
                                return eventPackItemListVM.byLocation
                            },
                            set: {
                                eventPackItemListVM.byLocation = $0
                                eventPackItemListVM.getEventPackItems(event: event)
                            }
                           )
                    )
                    .toggleStyle(.switch)
                    .frame(width: 130)
                    
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showEditEventItemList,
               onDismiss: {
            eventPackItemListVM.getEventPackItems(event: event)
        },
               content: { EventItemAddScreen(event: event) }
        )
        .onAppear(perform: {
            eventPackItemListVM.getEventPackItems(event: event)
        })
    }
}

//struct CategoryPackItemsList_Previews: PreviewProvider {
//    static var previews: some View {
//        let category = Category(context: Category.viewContext)
//        CategoryPackItemsList(category: category)
//    }
//}

