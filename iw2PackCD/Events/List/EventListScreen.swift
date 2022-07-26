//
//  EventListScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 08-Jun-22.
//

import SwiftUI

struct EventListScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var eventListVM = EventListVM()
    @State private var showForm: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Event.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Event>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(eventListVM.events, id: \.eventId) { item in
                    EventItemCell(event: item)
                }
                .onDelete(perform: deleteItems)
            }
            .refreshable(action: {
                eventListVM.getAllEvents()
            })
            .navigationTitle("Events with VM")
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
            
            .onAppear(perform: {
                eventListVM.getAllEvents()
            })
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
    let event: EventVM
    var body: some View {
        NavigationLink {
            EventPackItemsList(event: event.event)
        } label: {
            Text(event.name ?? "No Event")
        }
    }
}
