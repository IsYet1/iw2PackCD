//
//  PackItemListVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 19-May-22.
//

import Foundation
import CoreData
// TODO: Why do I need this Delegate here? Not in Movies. See fetchedResultController line commented out below
class PackItemListVM: NSObject, ObservableObject   {
    @Published var packItems = [PackItemVM]()
    
    private var fetchedResultsController: NSFetchedResultsController<PackItem>!
    
    func getAllPackItems() {
//        print("getAllPackItems")
        let request: NSFetchRequest<PackItem> = PackItem.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: PersistenceController.shared.container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        try? fetchedResultsController.performFetch()
        DispatchQueue.main.async {
            self.packItems = (self.fetchedResultsController.fetchedObjects ?? []).map(PackItemVM.init)
        }
    }
}

extension PackItemListVM: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.packItems = (controller.fetchedObjects as? [PackItem] ?? []).map(PackItemVM.init)
//            print(self.packItems)
        }
    }
}
