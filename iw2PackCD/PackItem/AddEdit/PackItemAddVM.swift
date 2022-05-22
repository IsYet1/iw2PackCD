//
//  PackItemFormViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import Foundation
import CoreData

class PackItemAddVM: ObservableObject {
    var name: String
    var vmPackItem: PackItem
    
    init(packItemIn: PackItem?) {
        name = ""
        vmPackItem = packItemIn ?? PackItem()
    }
    
//    func save() {
    func save(category: Category) {
        vmPackItem = PackItem(context: PackItem.viewContext)
        vmPackItem.name = name
        vmPackItem.category = category
        
        try? vmPackItem.save()
    }
}
