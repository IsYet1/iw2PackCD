//
//  CategoryListVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 19-May-22.
//

import Foundation
import CoreData
// TODO: Why do I need this Delegate here? Not in Movies. See fetchedResultController line commented out below
class EventListVM: NSObject, ObservableObject, NSFetchedResultsControllerDelegate  {
    @Published var events: [EventVM] = []
    @Published var eventNameForStartup: [String] = []
    
    private var fetchedResultsController: NSFetchedResultsController<Event>!
    
    func getEventNameForStartup() {
        if let eventName = (UserDefaults.standard.string(forKey: "eventNameForStartup")) {
            eventNameForStartup = [eventName]
        }
    }
    
    func getAllEvents(viewContext: NSManagedObjectContext) {
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        try? fetchedResultsController.performFetch()
        DispatchQueue.main.async {
            self.events = (self.fetchedResultsController.fetchedObjects ?? []).map(EventVM.init)
//            print("Get all events \(self.events)")
        }
    }
}
