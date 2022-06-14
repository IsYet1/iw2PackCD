//
//  PackItemEditVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 22-May-22.
//

import Foundation
import CoreData

class EventItemAddVM: ObservableObject {
    var vmPackItem: PackItemVM
    @Published var vmName: String
    var vmCategory: Category?
    
    init(packItemIn: PackItem) {
        vmPackItem = PackItemVM(packItem: packItemIn)
        vmName = vmPackItem.name
        vmCategory = vmPackItem.category
    }
    
//    func save() {
    func save() {
        vmPackItem.packItem.name = vmName
        vmPackItem.packItem.category = vmCategory
        
        try? vmPackItem.packItem.save()
    }
}
