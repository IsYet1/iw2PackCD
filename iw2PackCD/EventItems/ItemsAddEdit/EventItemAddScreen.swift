//
//  PackItemFormScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import SwiftUI

struct EventItemAddScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    let event: Event
    @State private var showAddItemForm: Bool = false
    
    @StateObject private var packItemListVm = PackItemListVM()
    
    var body: some View {
        VStack {
            HStack {
                CloseButton()
               Spacer()
                Button("Add Items") {
                    showAddItemForm = true
                }
            }.padding([.trailing], 20)
            Divider()
            Text("Add Items To: \(event.name!)").font(.title)
            Divider()
            
            List {
                ForEach(packItemListVm.groupedSortedFiltered, id:\.key) {sections in
                    Section(header: Text(sections.key)) {
                        ForEach(sections.value, id: \.packItemId) {item in
                            EventItemAddCell(
                                eventItemEditVM: EventItemEditVM(packItemIn: item.packItem, eventIn: event)
                                , eventItemCellType: .event
                            )
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .sheet(isPresented: $showAddItemForm,
               onDismiss: { packItemListVm.getAllPackItems(viewContext: viewContext) },
               content: { PackItemAddScreen() }
        )
        .onAppear(perform: {
            packItemListVm.getAllPackItems(viewContext: viewContext)
        })
        Spacer()
    }
}

struct PackItemFormScreen_Previews: PreviewProvider {
    static var previews: some View {
        PackItemAddScreen()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


