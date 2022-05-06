//
//  LocationViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 06-May-22.
//

import Foundation
import CoreData

struct LocationViewModel {
    let location: Location
    
    var locationId: NSManagedObjectID { return location.objectID }
    var name: String { return location.name ?? "" }
}
