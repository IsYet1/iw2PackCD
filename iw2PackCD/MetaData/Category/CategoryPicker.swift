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
        HStack {
            Text("Category").font(.headline).frame(width: 100)
            Picker("", selection: $selectedCategory) {
                Text("Select Category").tag(nil as Category?)
                ForEach(categoriesFR, id: \.self) {(category: Category ) in
                    Text(category.name ?? "").tag(category as Category?)
                }
            }
            .pickerStyle(.menu)
            Spacer()
        }
    }
}

//struct CategoryPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryPicker()
//    }
//}
