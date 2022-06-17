//
//  Category+Extension.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 29-Apr-22.
//

import Foundation
import CoreData

extension Event: BaseModel {
    func getEventPackItemsCount (event: Event) -> Int {
        let packItems = event.eventItems
        let count = packItems?.count ?? 0
        return count
    }
    
    func getPackItemNames(event: Event) -> [String] {
        // TODO: Streamline this.
        guard let packItemSet = event.eventItems,
              let packItemAry = packItemSet.allObjects as? [PackItem]
        else { return ["No Items"] }
        let mappedNames = PackItem.mapPackItemNames(packItems: packItemAry)
        return ["None"]
//        return getCategoryPackItemsCount(category: category) == 0
//        ? ["None"]
//        : mappedNames
    }
    
    
    
}
