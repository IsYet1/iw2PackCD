//
//  PackItemFormViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import Foundation
import CoreData

class PackItemFormViewModel: ObservableObject {
    var name: String = ""
    
    func save(category: Category) {
        let packItem = PackItem(context: PackItem.viewContext)
        packItem.name = name
        
        try? packItem.save()
        print("Category \(category.name!) - Item \(packItem.name!)")
        category.addToPackitems(packItem)
    }
}
