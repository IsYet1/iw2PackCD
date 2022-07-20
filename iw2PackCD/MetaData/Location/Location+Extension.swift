//
//  Location+Extension.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 05-May-22.
//

import Foundation
import CoreData

extension Location: BaseModel {
    func getLocationPackItemsCount (location: Location) -> Int {
        let packItems = location.packitems
        let count = packItems?.count ?? 0
        return count
    }
    
    func getPackItemNames(location: Location) -> [String] {
        // TODO: Streamline this.
        guard let packItemSet = location.packitems,
              let packItemAry = packItemSet.allObjects as? [PackItem]
        else { return ["No Items"] }
        let mappedNames = PackItem.mapPackItemNames(packItems: packItemAry)
        return getLocationPackItemsCount(location: location) == 0
        ? ["None"]
        : mappedNames
    }
    
    
}
