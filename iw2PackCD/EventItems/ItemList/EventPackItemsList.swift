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
                            EventPackItemsListCell(eventItemListCellVM: EventItemListCellVM(eventItemIn: eventItem))
                        }
                        // TODO: Re-enable swipe to delete from the event ?
                        //                        .onDelete {self.removeItemFromEvent(at: $0, items: sections.value )}
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

