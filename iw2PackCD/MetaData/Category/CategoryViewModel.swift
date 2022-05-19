//
//  CategoryViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 06-May-22.
//

import Foundation
import CoreData

struct CategoryViewModel: Hashable {
    let category: Category
    
    var categoryId: NSManagedObjectID { return category.objectID }
    var name: String { return category.name ?? "" }
}
