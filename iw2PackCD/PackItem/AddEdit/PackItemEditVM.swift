//
//  PackItemEditVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 22-May-22.
//

import Foundation
import CoreData

class PackItemEditVM: ObservableObject {
    var vmPackItem: PackItem
    @Published var vmName: String
    @Published var vmCategory: Category
    
    init(packItemIn: PackItem) {
        vmPackItem = packItemIn
        vmName = vmPackItem.name!
        vmCategory = vmPackItem.category!
    }
    
//    func save() {
    func save() {
        vmPackItem.name = vmName
        vmPackItem.category = vmCategory
        
        try? vmPackItem.save()
    }
}
