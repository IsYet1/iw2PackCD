//
//  PackItemEditVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 22-May-22.
//

import Foundation
import CoreData

class PackItemEditVM: ObservableObject {
    var vmName: String
    var vmPackItem: PackItem
    var vmCategory: Category
    
    init(packItemIn: PackItem) {
        vmPackItem = packItemIn
        vmName = vmPackItem.name!
        vmCategory = vmPackItem.category!
    }
    
//    func save() {
    func save(category: Category) {
        vmPackItem.name = vmName
        vmPackItem.category = category
        
        try? vmPackItem.save()
    }
}
