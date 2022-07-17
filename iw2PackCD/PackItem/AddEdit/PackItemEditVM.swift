//
//  PackItemEditVM.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 22-May-22.
//

import Foundation
import CoreData

class PackItemEditVM: ObservableObject {
    var vmPackItem: PackItemVM
    @Published var vmName: String
    @Published var vmCategory: Category?
    @Published var vmLocation: Location?
    
    init(packItemIn: PackItem) {
        vmPackItem = PackItemVM(packItem: packItemIn)
        vmName = vmPackItem.name
        vmCategory = vmPackItem.category
        vmLocation = vmPackItem.location
    }
    
//    func save() {
    func save() {
        vmPackItem.packItem.name = vmName
        vmPackItem.packItem.category = vmCategory
        vmPackItem.packItem.location = vmLocation
        
        try? vmPackItem.packItem.save()
    }
}
