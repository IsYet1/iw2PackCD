//
//  CategoryPackItemsList.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 15-May-22.
//

import SwiftUI

struct EventPackItemsList: View {
    @Environment(\.managedObjectContext) private var viewContext
    let event: Event
    @State private var showForm: Bool = false
    
    var body: some View {
        VStack {
            Text("\(event.name! ) Items").font(.headline)
            EventItemsCell(event: event)
            //            ListPackItems(category: event)
            Spacer()
        }
        .toolbar {
            //                ToolbarItem(placement: .navigationBarLeading) {
            //                    EditButton()
            //                }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add Items to this Event") {
                    self.showForm = true
                }
            }
        }
        .sheet(isPresented: $showForm,
//               onDismiss: { packItemListVm.getAllPackItems() },
               content: { EventItemAddScreen(event: event) }
        )
    }
}

struct EventItemsCell: View {
    let event: Event
    var body: some View {
        Text("Event pack items here \(event.getEventPackItemsCount(event: event))")
    }
}

struct ListEventItems: View {
    let category: Category
    var body: some View {
        let names1 = category.getPackItemNames(category: category)
        List(names1, id: \.self) {name in
            Text(name)
        }
    }
}

//struct CategoryPackItemsList_Previews: PreviewProvider {
//    static var previews: some View {
//        let category = Category(context: Category.viewContext)
//        CategoryPackItemsList(category: category)
//    }
//}
