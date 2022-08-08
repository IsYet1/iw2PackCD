//
//  CategoryPackItemsList.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 15-May-22.
//

import SwiftUI

// TODO: Need to work on the synching. Not 100% sure the code change to move the rows to the Cell view is working all the time.
// See commit# 87569423f97b582f84509f262c511d5b7275beda for that change. Basically copy the Cell HStack and paste just below the Event..Cell line below.

struct EventPackItemsList: View {
    
    let eventName: String
    @StateObject private var eventPackItemListVM = EventPackItemListVM()
    @State private var showEditEventItemList: Bool = false
    
    var body: some View {
//        let itemsCount = event.eventItems?.count ?? 0
        
        VStack {
            Text("\(eventName )").font(.title)
//                    let linkText = "\(event.name) (\(event.countTotal) / \(event.countStaged) / \(event.countPacked))"
            Text("(\(eventPackItemListVM.countTotal) / \(eventPackItemListVM.countStaged) / \(eventPackItemListVM.countPacked))").font(.footnote)
            
            List {
                ForEach(eventPackItemListVM.groupedSortedFiltered, id:\.key) {sections in
                    Section(header: Text(sections.key)) {
                        ForEach(sections.value, id: \.id) {eventItem in
                            EventPackItemsListCell(eventPackItemListVM: eventPackItemListVM, eventItem: eventItem)
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
        .sheet(isPresented: $showEditEventItemList,
               onDismiss: {
                eventPackItemListVM.refreshList()
        },
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

