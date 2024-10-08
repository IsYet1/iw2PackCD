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
    
    @Environment(\.colorScheme) var colorScheme
    let eventName: String
    @StateObject private var eventPackItemListVM = EventPackItemListVM()
    @State private var idOfItemToEdit: NSManagedObjectID?
    @State private var packItemToEdit: PackItem? = nil
    @State private var showEditEventItemList: Bool = false
    @State private var editItem: Bool = false
    let nbsp = "\u{00a0}" // Not used but leaving in for reference
    let countSeparator = "/\u{00a0}"
    
    var body: some View {
        // TODO: Move this to an extension or const.
        let defaultColor = (colorScheme == .dark) ? Color.white : Color.black
        
        VStack {
            Text("\(eventName )").font(.title)
            
            HStack {
                Text("\(eventPackItemListVM.countTotal - eventPackItemListVM.countStaged)")
                    .underline(eventPackItemListVM.hideStaged)
                    .fontWeight(eventPackItemListVM.hideStaged ? .bold : .regular)
                    .foregroundColor(eventPackItemListVM.hideStaged ? Color.blue : defaultColor)
                Text("\(countSeparator)")
                Text("\(eventPackItemListVM.countTotal - eventPackItemListVM.countPacked)")
                    .underline(eventPackItemListVM.hidePacked)
                    .fontWeight(eventPackItemListVM.hidePacked ? .bold : .regular)
                    .foregroundColor(eventPackItemListVM.hidePacked ? Color.blue : defaultColor)
                if (eventPackItemListVM.countSkipped > 0) {
                    Text("\(countSeparator)")
                    Text("\(eventPackItemListVM.countSkipped)").foregroundColor(Color(.systemRed))
                }
                HStack {
                    Text("[")
                    Text("\(eventPackItemListVM.countTotal)")
                    Text("]")
                }
            }
            .font(.footnote)
            
            List {
                ForEach(eventPackItemListVM.groupedSortedFiltered, id:\.key) {sections in
                    Section(header: Text(sections.key).sectionHeaderStyle()) {
//                    Section(header: Text(sections.key)) {
                        ForEach(sections.value, id: \.id) {eventItem in
                            HStack {
                                EventPackItemsListCell(eventPackItemListVM: eventPackItemListVM, eventItem: eventItem)
                            }
                            .swipeActions(
                                edge: HorizontalEdge.leading ,
                                allowsFullSwipe: true,
                                content: {
                                    Button(
                                        action: {
                                            eventPackItemListVM.updatePackedStatusThenReload(checked: true, eventItem: eventItem, phase: .skipped)
                                        },
                                        label: {Image(systemName: "strikethrough")}
                                    )
                                    .tint(.gray)
                                    .disabled(eventItem.skipped)
                                }
                            )
                            .swipeActions(
                                edge: HorizontalEdge.trailing ,
                                allowsFullSwipe: false,
                                content: {
                                    Button(
                                        action: {
                                            eventPackItemListVM.removeSelectedEventItem(eventItem: eventItem)
                                        },
                                        label: {Image(systemName: "delete.right")})
                                    .tint(.blue)
                                }
                            )
                            .swipeActions(
                                edge: HorizontalEdge.trailing ,
                                allowsFullSwipe: false,
                                content: {
                                    Button(
                                        action: {
                                            self.packItemToEdit = eventItem.item
                                            idOfItemToEdit = eventItem.item!.objectID
                                            self.editItem = idOfItemToEdit != nil
                                        },
                                        label: {Image(systemName: "tshirt")})
                                    .tint(.blue)
                                }
                            )
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
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
            if let curItemToEdit = idOfItemToEdit {
                PackItemEditScreen2(editItemVM: PackItemEditVM(packItemIn: PackItem.byId(id: curItemToEdit) as! PackItem) )
//                PackItemEditScreen2(editItemVM: PackItemEditVM(packItemIn: $editItem!) )
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

