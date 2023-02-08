//
//  PreviewData.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 01-02-2023.
//

import Foundation
import CoreData

struct CreatePreviewData {
    var context: NSManagedObjectContext
    
    var categories = ["Category 1", "Category 2", "Category 3", "Category 4"]
    var locations = ["Location 1", "Location  2", "Location  3", "Location  4"]
    var events = ["Event 1", "Event  2", "Event  3", "Event  4"]
    var items = ["Item 11", "Item  2", "Item  3", "Item  4"]
    
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
    
    func createItems() {
        items.forEach{previewDataValue in
            let previewDataItem = PackItem(context: context)
            previewDataItem.name = previewDataValue
            try? previewDataItem.save()
        }
    }
    
    func createAllPreviewData() {
        createCategories()
        createLocations()
        createEvents()
        createItems()
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
    
}
