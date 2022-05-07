//
//  PackItemViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import Foundation
import CoreData

struct PackItemViewModel {
    let packItem: PackItem
    
    var packItemId: NSManagedObjectID { return packItem.objectID }
    var name: String { return packItem.name ?? "" }
}
