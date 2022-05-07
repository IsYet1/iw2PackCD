//
//  CoreDataManager.swift
//  TodoApp
//
//  Created by Mohammad Azam on 3/29/21.
//

import Foundation
import CoreData
import CloudKit

// Copied from Udemy ToDo app. Not implemented as of 2020-05
// The generated code for a Core Data CloudKit app has similar code.
class CoreDataManagerCloudKit {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManagerCloudKit()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentCloudKitContainer(name: "TodoAppModel")
        persistentContainer.persistentStoreDescriptions.first!.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
}
