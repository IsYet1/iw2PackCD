//
//  PackItemListVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 19-May-22.
//

import Foundation
import CoreData
class PackItemListVM: NSObject, ObservableObject   {
    @Published var packItems = [PackItemVM]()
    @Published var groupedSortedFiltered: [(key: String, value: [PackItemVM] ) ] = []
    
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
            self.groupedSortedFiltered = groupItems(items: self.packItems)
        }
    }
}
func groupItems(items: [PackItemVM] ) -> [(key: String, value: [PackItemVM] ) ]  {
    var orderList: [(key: String, value: [PackItemVM] ) ] {
        let itemsSorted = items.sorted(by: { $0.name < $1.name })
        let listGroup: [String: [PackItemVM]] = Dictionary(grouping: itemsSorted, by: { packItem in
            return (packItem.categoryIsSet && packItem.category.name != nil)
                ?  packItem.category.name!
                : ""
            //            return false //byLocation
            //            ? packItem.location ?? "___ LOCATION not set"
            //            : packItem.category ?? "___ CATEGORY not set"
        })
        return listGroup.sorted(by: {$0.key < $1.key})
    }
    return orderList
}


extension PackItemListVM: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.packItems = (controller.fetchedObjects as? [PackItem] ?? []).map(PackItemVM.init)
            //            print(self.packItems)
        }
    }
}
