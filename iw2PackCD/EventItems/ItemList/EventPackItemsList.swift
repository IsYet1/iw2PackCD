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
        VStack {
            Text("\(event.name! )").font(.title)
            Text("\(itemsCount) items").font(.footnote)
            
            List(eventPackItemListVM.eventItems, id: \.id) {eventItem in
                EventPackItemsListCell(eventItemListCellVM: EventItemListCellVM(eventItemIn: eventItem))
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

//struct CategoryPackItemsList_Previews: PreviewProvider {
//    static var previews: some View {
//        let category = Category(context: Category.viewContext)
//        CategoryPackItemsList(category: category)
//    }
//}
