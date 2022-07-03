//
//  CategoryPackItemsList.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 15-May-22.
//

import SwiftUI

struct EventPackItemsList: View {
    @State var eventPackItemListVM: EventPackItemListVM
    @State private var showEditEventItemList: Bool = false
    
    var body: some View {
        VStack {
            Text("\(eventPackItemListVM.vmEvent.name! ) Items").font(.headline)
            List(eventPackItemListVM.eventPackItemNames, id: \.self) {packItemName in
                Text(packItemName)
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
           onDismiss: { eventPackItemListVM.refreshEventPackItemListNames() },
           content: { EventItemAddScreen(event: eventPackItemListVM.vmEvent) }
        )
    }
}

//struct CategoryPackItemsList_Previews: PreviewProvider {
//    static var previews: some View {
//        let category = Category(context: Category.viewContext)
//        CategoryPackItemsList(category: category)
//    }
//}
