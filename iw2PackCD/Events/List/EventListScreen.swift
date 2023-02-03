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
    
    // Note: navPath isn't used. The last used Event is retrieved and used instead.
    // Leaving in for example purposes.
    //    @State private var navPath: [String] = ["Run list ", "Run list, weekend "]
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Event.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Event>
    
    var body: some View {
        NavigationStack (path: $eventListVM.eventNameForStartup) {
            List {
                ForEach(eventListVM.events, id: \.eventId) { event in
                    let linkText = "\(event.name) (\(event.countTotal) / \(event.countTotal - event.countStaged) / \(event.countTotal - event.countPacked) / \(event.countSkipped))"
                    NavigationLink(linkText, value: event.name)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationDestination(for: String.self) {
                eventName in
                EventPackItemsList(eventName: eventName)
            }
            .refreshable(action: {
                eventListVM.getAllEvents(viewContext: viewContext)
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
                eventListVM.getEventNameForStartup()
                eventListVM.getAllEvents(viewContext: viewContext)
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

struct EventListScreen_Previews: PreviewProvider {
    static var previews: some View {
        EventListScreen()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

