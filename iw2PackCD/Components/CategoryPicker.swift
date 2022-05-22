//
//  CategoryPicker.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 21-May-22.
//

import SwiftUI

struct CategoryPicker: View {
    @Binding var selectedCategory: Category?
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)]
    )
    private var categoriesFR: FetchedResults<Category>
    
    var body: some View {
        Picker("", selection: $selectedCategory) {
            ForEach(categoriesFR, id: \.self) {(category: Category ) in
                Text(category.name ?? "").tag(category as Category?)
            }
        }
    }
}

//struct CategoryPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryPicker()
//    }
//}
