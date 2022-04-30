//
//  CategoryFormViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 30-Apr-22.
//

import Foundation

class CategoryFormViewModel: ObservableObject {
    var name: String = ""
    
    func save() {
        let category = Category(context: Category.viewContext)
        category.name = name
        
        try? category.save()
    }
}
