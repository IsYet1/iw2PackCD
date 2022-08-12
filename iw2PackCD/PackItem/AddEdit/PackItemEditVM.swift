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
    var metaDataIsInvalid: Bool {
        get {
            return vmCategory == nil || vmLocation == nil
        }
    }
    
    init(packItemIn: PackItem) {
        vmPackItem = PackItemVM(packItem: packItemIn)
        vmName = vmPackItem.name
        vmCategory = vmPackItem.categoryIsSet ? vmPackItem.category : nil
        vmLocation = vmPackItem.locationIsSet ? vmPackItem.location : nil
    }
    
    func save() {
        vmPackItem.packItem.name = vmName
        vmPackItem.packItem.category = vmCategory
        vmPackItem.packItem.location = vmLocation
        
        try? vmPackItem.packItem.save()
    }
}
