//
//  Utilities.Service.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 9/3/22.
//

import Foundation
import CoreData

class UtilitiesService: ObservableObject {
    private let prefix = "Sample:: "
    private var locationFormVM = LocationFormViewModel()
    private var categoryFormVM = CategoryFormViewModel()
    private var eventFormVM = EventFormViewModel()
    private var defaults = UserDefaults.standard
    
    static var viewContext: NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }
    
    let locations = ["Bedroom", "Closet"] //, "Kitchen", "Living Room", "Garage"]
    let categories = ["Pants", "Shirts"] //, "Chargers", "Shoes", "Run Gear"]
    let events = ["Weekend", "Day Out"] //, "Chargers", "Shoes", "Run Gear"]
//    let items = [{name: "Blue Chino"}]
    
    func addSampleData() {
        addLocations()
        addCategories()
        addEvents()
    }
    
    func removeSampleData()  {
        do {
            try removeSampleLocations()
        } catch {
            let nsError = error as NSError
            fatalError("Error deleting items \(nsError), \(nsError.userInfo)")
        }
    }
    
    func startOnEvents() {
        setStartTab(tabNum: 1)
    }
    
    func startOnUtilities() {
        setStartTab(tabNum: 0)
    }
   
    private func setStartTab(tabNum: Int) {
        UserDefaults.standard.set(tabNum, forKey: "startTab")
    }
    
    private func addLocations() {
        locations.forEach( {location in
            locationFormVM.name = prefix + location
            locationFormVM.save()
        })
    }
    
    private func removeSampleLocations() throws {
//        let locations = Location.all()
//        for location in locations {
//            print(location.entity)
//            Self.viewContext.delete(location)
//        }
//        do {
//            try Self.viewContext.save()
//        } catch {
//            throw error
//        }
    }
    
    private func addCategories() {
        categories.forEach( {category in
            categoryFormVM.name = prefix + category
            categoryFormVM.save()
        })
    }
    
    private func addEvents() {
        events.forEach( {event in
            eventFormVM.name = prefix + event
            eventFormVM.save()
        })
    }
    
    func backupData() -> String {
        return backupCategories()
    }
    
    func backupCategories() -> String {
        let categories: [Category] = Category.all()
        let names = categories.compactMap({category in
            return category.name
        })
        _ = try? NSKeyedArchiver.archivedData(withRootObject: names, requiringSecureCoding: false)
        return("Category count: \(names.count )")
//        UserDefaults.standard.set
    }
}
