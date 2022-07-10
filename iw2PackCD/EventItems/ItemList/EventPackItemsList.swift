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
    @State private var eventItems: [EventItem] = []
    @State private var showEditEventItemList: Bool = false
    
    var body: some View {
        let itemsCount = event.eventItems?.count ?? 0
        let itemsForList = eventPackItemListVM.eventItems
        let groupedItems = groupItems(items: itemsForList)
        
        VStack {
            Text("\(event.name! )").font(.title)
            Text("\(itemsCount) items").font(.footnote)
            
//            List(itemsForList, id: \.id) {eventItem in
//                EventPackItemsListCell(eventItemListCellVM: EventItemListCellVM(eventItemIn: eventItem))
//            }
            List {
                ForEach(groupedItems, id:\.key) {sections in
                    Section(header: Text(sections.key)) {
                        ForEach(sections.value, id: \.id) {eventItem in
                            EventPackItemsListCell(eventItemListCellVM: EventItemListCellVM(eventItemIn: eventItem))
                        }
//                        .onDelete {self.removeItemFromEvent(at: $0, items: sections.value )}
                    }
                }
            }
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit Item List For This Event") {
                    self.showEditEventItemList = true
                }
            }
        }
        .sheet(isPresented: $showEditEventItemList,
               onDismiss: {
            eventPackItemListVM.getEventPackItems(event: event)
//            eventPackItemListVM.refreshEventPackItemList()
        },
               content: { EventItemAddScreen(event: event) }
        )
        .onAppear(perform: {
            eventPackItemListVM.getEventPackItems(event: event)
            eventPackItemListVM.refreshEventPackItemList()
            eventItems = eventPackItemListVM.eventItems
        })
    }
}

private func groupItems(items: [EventItem]) -> [(key: String, value: [EventItem] ) ]  {
    var orderList: [(key: String, value: [EventItem] ) ] {
        let itemsSorted = items.sorted(by: { $0.item?.name ?? "___ no name" < $1.item?.name ?? "___ no name" })
        let itemsFiltered = true // !filterUnpacked
        ? itemsSorted
        : itemsSorted.filter() {!($0.packed) }
        let listGroup: [String: [EventItem]] = Dictionary(grouping: itemsFiltered, by: { eventItem in
            return eventItem.item?.category?.name ?? "___ No Category"
            //            return false //byLocation
//            ? packItem.location ?? "___ LOCATION not set"
//            : packItem.category ?? "___ CATEGORY not set"
        })
        return listGroup.sorted(by: {$0.key < $1.key})
    }
    return orderList
}

//struct CategoryPackItemsList_Previews: PreviewProvider {
//    static var previews: some View {
//        let category = Category(context: Category.viewContext)
//        CategoryPackItemsList(category: category)
//    }
//}
