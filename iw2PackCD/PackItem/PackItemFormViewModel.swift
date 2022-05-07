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
    
    func save() {
        let packItem = PackItem(context: PackItem.viewContext)
        packItem.name = name
        
        try? packItem.save()
    }
}
