//
//  PackItemFormViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import Foundation
import CoreData

class PackItemAddViewModel: ObservableObject {
    var name: String = ""
    
    func save() {
//    func save(category: Category) {
        let packItem = PackItem(context: PackItem.viewContext)
        packItem.name = name
//        packItem.category = category
        
        try? packItem.save()
    }
}
