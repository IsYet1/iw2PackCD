//
//  EventListScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 08-Jun-22.
//

import SwiftUI
import CoreData

struct EventListScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var eventListVM = EventListVM()
    @State private var showForm: Bool = false
    
    @State private var navPath: [Event] = []
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Event.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Event>
    
    var body: some View {
        NavigationStack (path: $navPath) {
            List {
                ForEach(eventListVM.events, id: \.eventId) { event in
                    NavigationLink(event.name, value: event.event)
//                                        EventItemCell(event: event)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationDestination(for: Event.self) {
                event in
                EventPackItemsList(event: event, eventName: event.name!)
            }
            .refreshable(action: {
                eventListVM.getAllEvents()
            })
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

//struct EventItemCell: View {
//    let event: EventVM
//    var body: some View {
//        NavigationLink {
//            EventPackItemsList(event: event.event)
//        } label: {
//            Text(event.name )
//        }
//    }
//}
