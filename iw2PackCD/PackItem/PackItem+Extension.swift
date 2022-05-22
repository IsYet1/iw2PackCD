//
//  PackItem+Extension.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import Foundation
import CoreData

extension PackItem: BaseModel {
    
    var packItemName: String {
        return name ?? "Not Set"
    }
    
    var packItemCategory: Category {
        return category ?? Category(context: Category.viewContext)
    }
    
    var categoryName: String {
        return category?.name ?? "Not Set"
    }
    
    static func updatePackItem(packItem: PackItem, name: String) {
        packItem.setValue(name, forKey: "packItemName")
        try? packItem.save()
    }
    
    static func mapPackItemNames (packItems: [PackItem]) -> [String] {
        let names = packItems.compactMap({packItem in
            return packItem.name
        })
        return names
    }
 }
