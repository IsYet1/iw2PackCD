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
        Text("Category pack items here \(getCategoryPackItemsCount(category: category))")
    }
}

struct ListPackItems: View {
    let category: Category
    var body: some View {
        let names = getPackItemNames(category: category)
        List(names, id: \.self) {name in
            Text(name)
        }
    }
}

func getCategoryPackItemsCount (category: Category) -> Int {
    let packItems = category.packitems
    let count = packItems?.count ?? 0
    return count
}

func mapPackItemNames (packItems: [PackItem]) -> [String] {
    let names = packItems.compactMap({packItem in
        return packItem.name
    })
    return names
}

func getPackItemNames(category: Category) -> [String] {
    guard let packItemSet = category.packitems, let packItemAry = packItemSet.allObjects as? [PackItem]
        else { return ["No Items"] }
    let mappedNames = mapPackItemNames(packItems: packItemAry)
//    return mappedNames
    let names = getCategoryPackItemsCount(category: category) == 0
    ? ["None"]
    : mappedNames
    
    return names
}

struct CategoryPackItemsList_Previews: PreviewProvider {
    static var previews: some View {
        let category = Category(context: Category.viewContext)
        CategoryPackItemsList(category: category)
    }
}
