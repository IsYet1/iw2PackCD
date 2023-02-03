//
//  PreviewData.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 01-02-2023.
//

import Foundation
import CoreData

struct CreatePreviewData {
    public var context: NSManagedObjectContext
    
    // TODO: Fix this so that PUBLIC isn't required.
    public var categories = ["Category 1", "Category 2", "Category 3", "Category 4"]
    public var locations = ["Location 1", "Location  2", "Location  3", "Location  4"]
    public var events = ["Event 1", "Event  2", "Event  3", "Event  4"]
    
    func createCategories() {
        categories.forEach{previewDataValue in
            let previewDataItem = Category(context: context)
            previewDataItem.name = previewDataValue
            try? previewDataItem.save()
        }
    }
    
    func createLocations() {
        locations.forEach{previewDataValue in
            let previewDataItem = Location(context: context)
            previewDataItem.name = previewDataValue
            try? previewDataItem.save()
        }
    }
    
    func createEvents() {
        events.forEach{previewDataValue in
            let previewDataItem = Event(context: context)
            previewDataItem.name = previewDataValue
            try? previewDataItem.save()
        }
    }
    
//    func createMetaData(type: String, count: Int, typeContext: NSManagedObjectContext) {
//        (1...count).forEach(ndx in
//
//        )
//        for(ndx, = 0, ndx < count, ndx++) {
//
//        }
//        locations.forEach{previewDataValue in
//            let previewDataItem = Location(context: context)
//            previewDataItem.name = previewDataValue
//            try? previewDataItem.save()
//        }
//    }
    
    func createAllPreviewData() {
        createCategories()
        createLocations()
        createEvents()
    }
}
