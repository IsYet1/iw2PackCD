//
//  Category+Extension.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 29-Apr-22.
//

import Foundation
import CoreData

extension Category: BaseModel {
    func getCategoryPackItemsCount (category: Category) -> Int {
        let packItems = category.packitems
        let count = packItems?.count ?? 0
        return count
    }
    
    func getPackItemNames(category: Category) -> [String] {
        // TODO: Streamline this.
        guard let packItemSet = category.packitems,
              let packItemAry = packItemSet.allObjects as? [PackItem]
        else { return ["No Items"] }
        let mappedNames = PackItem.mapPackItemNames(packItems: packItemAry)
        return getCategoryPackItemsCount(category: category) == 0
        ? ["None"]
        : mappedNames
    }
    
    
    
}
