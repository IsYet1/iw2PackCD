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
                            EventPackItemsListCell(eventPackItemListVM: eventPackItemListVM, eventItem: eventItem, event: event)
                        }
                    }
                }
            }
            .refreshable(action: {
                eventPackItemListVM.getEventPackItems(event: event)
            })
            
            
            HStack (alignment: .center, spacing: 50) {
                Toggle(isOn: Binding<Bool> (
                    get: {
                        return eventPackItemListVM.filterItems
                    },
                    set: {
                        eventPackItemListVM.filterItems = $0
                        eventPackItemListVM.getEventPackItems(event: event)
                    }
                ),
                       label: {Text("Unpacked").font(.footnote)}
                )
                .toggleStyle(CheckboxToggleStyle(style: .circle))

                Toggle(isOn: Binding<Bool> (
                        get: {
                            return eventPackItemListVM.byLocation
                        },
                        set: {
                            eventPackItemListVM.byLocation = $0
                            eventPackItemListVM.getEventPackItems(event: event)
                        }
                       ),
                       label: {Text("Location").font(.footnote)}
                )
                .toggleStyle(CheckboxToggleStyle(style: .circle))

                Button("Reset") {
                    eventPackItemListVM.resetListStatus()
                    eventPackItemListVM.getEventPackItems(event: event)
                }.buttonStyle(.bordered)
            }
            .padding(15)
            .background(Color.gray.opacity(0.3), in: Rectangle())
            .cornerRadius(7)
            
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

