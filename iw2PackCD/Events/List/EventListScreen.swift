//
//  EventListScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 08-Jun-22.
//

import SwiftUI

struct EventListScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showForm: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Event.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Event>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    EventItemCell(item: item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add an Event") {
                        self.showForm = true
                    }
                }
            }
            .sheet(isPresented: $showForm, content: {
                EventFormScreen()
            })
            Text("Select an item")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//struct EventListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        EventListScreen()
//    }
//}

struct EventItemCell: View {
    let item: Event
    var body: some View {
        NavigationLink {
            EventPackItemsList(eventPackItemListVM: EventPackItemListVM(event: item))
//            Text("Item at \(item.name ?? "No Event")")
        } label: {
            Text(item.name ?? "No Event")
        }
    }
}
