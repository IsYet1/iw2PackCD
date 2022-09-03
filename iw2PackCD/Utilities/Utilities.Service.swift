//
//  Utilities.Service.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 9/3/22.
//

import Foundation

class UtilitiesService: ObservableObject {
    private let prefix = "Sample:: "
    private var locationFormVM = LocationFormViewModel()
    private var categoryFormVM = CategoryFormViewModel()
    
    let locations = ["Bedroom", "Closet"] //, "Kitchen", "Living Room", "Garage"]
    let categories = ["Pants", "Shirts"] //, "Chargers", "Shoes", "Run Gear"]
    let events = ["Weekend", "Day Out"] //, "Chargers", "Shoes", "Run Gear"]
//    let items = [{name: "Blue Chino"}]
    
    func addSampleData() {
        addLocations()
        addCategories()
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
    
    private func addCategories() {
        categories.forEach( {category in
            categoryFormVM.name = prefix + category
            categoryFormVM.save()
            
        })
    }
}
