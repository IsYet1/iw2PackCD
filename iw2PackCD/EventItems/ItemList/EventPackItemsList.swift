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
    
    @State private var byLocation: Bool = false
    @State private var filterUnpacked: Bool = false
    
    var body: some View {
        let itemsCount = event.eventItems?.count ?? 0
        let groupedItems = groupItems(items: eventPackItemListVM.eventItems, filterItems: filterUnpacked)
        
        VStack {
            Text("\(event.name! )").font(.title)
            Text("\(itemsCount) items").font(.footnote)
            
            List {
                ForEach(groupedItems, id:\.key) {sections in
                    Section(header: Text(sections.key)) {
                        ForEach(sections.value, id: \.id) {eventItem in
                            EventPackItemsListCell(eventItemListCellVM: EventItemListCellVM(eventItemIn: eventItem))
                        }
                        // TODO: Re-enable swipe to delete from the event ?
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
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Toggle("Unpacked", isOn: $filterUnpacked).toggleStyle(.switch)
                    Toggle("By Location", isOn: $byLocation).toggleStyle(.switch)
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

// TODO: Move this to the VM (service)?
private func groupItems(items: [EventItem], filterItems: Bool = false) -> [(key: String, value: [EventItem] ) ]  {
    var orderList: [(key: String, value: [EventItem] ) ] {
        let itemsSorted = items.sorted(by: { $0.item?.name ?? "___ no name" < $1.item?.name ?? "___ no name" })
        let itemsFiltered = !filterItems
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
