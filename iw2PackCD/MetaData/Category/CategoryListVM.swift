//
//  CategoryListVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 19-May-22.
//

import Foundation
import CoreData
// TODO: Why do I need this Delegate here? Not in Movies. See fetchedResultController line commented out below
class CategoryListVM: NSObject, ObservableObject, NSFetchedResultsControllerDelegate  {
    @Published var categories = [CategoryViewModel]()
    
    private var fetchedResultsController: NSFetchedResultsController<Category>!
    
    func getAllCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: PersistenceController.shared.container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        try? fetchedResultsController.performFetch()
        DispatchQueue.main.async {
            self.categories = (self.fetchedResultsController.fetchedObjects ?? []).map(CategoryViewModel.init)
            print("Get all categories \(self.categories)")
        }
    }
}
