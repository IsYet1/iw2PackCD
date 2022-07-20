//
//  PackItemViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import Foundation
import CoreData

struct PackItemVM {
    let packItem: PackItem
    
    var packItemId: NSManagedObjectID { return packItem.objectID }
    var name: String { return packItem.name ?? "" }
    var category: Category { return packItem.category ?? Category() }
    var location: Location { return packItem.location ?? Location() }
}
