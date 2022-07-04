//
//  CategoryPackItemsList.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 15-May-22.
//

import SwiftUI

struct EventPackItemsList: View {
    
    @State private var eventPackItemListVM: EventPackItemListVM
    @State private var eventItems: [EventItem] = []
    @State private var showEditEventItemList: Bool = false
    
    init(event: Event) {
        self.eventPackItemListVM = EventPackItemListVM(event: event)
    }
    
    var body: some View {
        VStack {
            Text("\(eventPackItemListVM.vmEvent.name! ) Items").font(.headline)
            
            List(eventItems, id: \.id) {eventItem in
                Text(String(eventItem.packed))
                Text(eventItem.item!.name!)
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
           onDismiss: { eventPackItemListVM.refreshEventPackItemList() },
           content: { EventItemAddScreen(event: eventPackItemListVM.vmEvent) }
        )
        .onAppear(perform: {
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
