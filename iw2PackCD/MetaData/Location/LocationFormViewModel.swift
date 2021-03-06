//
//  CategoryFormViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 30-Apr-22.
//

import Foundation
import CoreData

class LocationFormViewModel: ObservableObject {
    var name: String = ""
    
    func save() {
        let location = Location(context: Location.viewContext)
        location.name = name
        
        try? location.save()
    }
}

