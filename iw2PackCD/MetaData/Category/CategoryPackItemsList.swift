//
//  CategoryPackItemsList.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 15-May-22.
//

import SwiftUI

struct CategoryPackItemsList: View {
    @Environment(\.managedObjectContext) private var viewContext
    let category: Category
    var body: some View {
        VStack {
            Text("\(category.name! ) Items").font(.headline)
            PackItemsCell(category: category)
            ListPackItems(category: category)
            Spacer()
        }
    }
}

struct PackItemsCell: View {
    let category: Category
    var body: some View {
        Text("Category pack items here \(category.getCategoryPackItemsCount(category: category))")
    }
}

struct ListPackItems: View {
    let category: Category
    var body: some View {
        let names1 = category.getPackItemNames(category: category)
        List(names1, id: \.self) {name in
            Text(name)
        }
    }
}

struct CategoryPackItemsList_Previews: PreviewProvider {
    static var previews: some View {
        let category = Category(context: Category.viewContext)
        CategoryPackItemsList(category: category)
    }
}
