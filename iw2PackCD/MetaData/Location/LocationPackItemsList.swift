//
//  CategoryPackItemsList.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 15-May-22.
//

import SwiftUI

struct LocationPackItemsList: View {
    @Environment(\.managedObjectContext) private var viewContext
    let location: Location
    var body: some View {
        VStack {
            Text("\(location.name! ) Items").font(.headline)
            LocationPackItemsCell(location: location)
            LocationListPackItems(location: location)
            Spacer()
        }
    }
}

struct LocationPackItemsCell: View {
    let location: Location
    var body: some View {
        Text("Location pack items here \(location.getLocationPackItemsCount(location: location))")
    }
}

struct LocationListPackItems: View {
    let location: Location
    var body: some View {
        let names1 = location.getPackItemNames(location: location)
        List(names1, id: \.self) {name in
            Text(name)
        }
    }
}

//struct CategoryPackItemsList_Previews: PreviewProvider {
//    static var previews: some View {
//        let category = Category(context: Category.viewContext)
//        CategoryPackItemsList(category: category)
//    }
//}
