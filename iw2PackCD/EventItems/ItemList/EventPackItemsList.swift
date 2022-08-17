//
//  CategoryPackItemsList.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 15-May-22.
//

import SwiftUI
import CoreData

// TODO: Need to work on the synching. Not 100% sure the code change to move the rows to the Cell view is working all the time.
// See commit# 87569423f97b582f84509f262c511d5b7275beda for that change. Basically copy the Cell HStack and paste just below the Event..Cell line below.

struct EventPackItemsList: View {
    
    let eventName: String
    @StateObject private var eventPackItemListVM = EventPackItemListVM()
    @State private var itemToEdit: NSManagedObjectID?
    @State private var showEditEventItemList: Bool = false
    @State private var editItem: Bool = false
    let nbsp = "\u{00a0}" // Not used but leaving in for reference
    let countSeparator = "/\u{00a0}"
    
    var body: some View {
        
        VStack {
            Text("\(eventName )").font(.title)
            
            HStack {
                Text("(")
                Text("\(eventPackItemListVM.countTotal)")
                Text("\(countSeparator)")
                Text("\(eventPackItemListVM.countTotal - eventPackItemListVM.countStaged)")
                Text("\(countSeparator)")
                Text("\(eventPackItemListVM.countTotal - eventPackItemListVM.countPacked)")
                if (eventPackItemListVM.countSkipped > 0) {
                    Text("\(countSeparator)")
                    Text("\(eventPackItemListVM.countSkipped)").foregroundColor(Color(.systemRed))
                }
                Text(")")
            }
                .font(.footnote)
            
            List {
                ForEach(eventPackItemListVM.groupedSortedFiltered, id:\.key) {sections in
                    Section(header: Text(sections.key)) {
                        ForEach(sections.value, id: \.id) {eventItem in
                            HStack {
                                EventPackItemsListCell(eventPackItemListVM: eventPackItemListVM, eventItem: eventItem)
                                Spacer()
                                Button("...", action: {
                                    itemToEdit = eventItem.item!.objectID
                                    self.editItem = itemToEdit != nil
                                })
                            }
                        }
                    }
                }
            }
            .refreshable(action: {
                eventPackItemListVM.refreshList()
            })
            
            EventPackItemsListActions(eventPackItemListVM: eventPackItemListVM)
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                VStack {
                    Button("Add/Remove Items") {
                        self.showEditEventItemList = true
                    }
                }
            }
        }
        .sheet(isPresented: $editItem,
               onDismiss: { eventPackItemListVM.refreshList() },
               content: {
            if let curItemToEdit = itemToEdit {
                PackItemEditScreen2(editItemVM: PackItemEditVM(packItemIn: PackItem.byId(id: curItemToEdit) as! PackItem) )
                }
            }
        )
        .sheet(isPresented: $showEditEventItemList,
               onDismiss: { eventPackItemListVM.refreshList() },
               content: { EventItemAddScreen(event: eventPackItemListVM.curEvent!.event) }
        )
        .onAppear(perform: {
            eventPackItemListVM.initEventPackItemListVM(eventName: eventName)
        })
    }
}

//struct CategoryPackItemsList_Previews: PreviewProvider {
//    static var previews: some View {
//        let category = Category(context: Category.viewContext)
//        CategoryPackItemsList(category: category)
//    }
//}

