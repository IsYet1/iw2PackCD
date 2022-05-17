//
//  PackItemEditScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 16-May-22.
//

import SwiftUI

struct PackItemEditScreen: View {
    let packItem: PackItem
    @State private var itemName = ""
    
    @State private var packItemName = ""
    var body: some View {
        VStack {
            Form {
                TextField("Item Name", text: $itemName)
            }
            Text(packItem.packItemName)
            Spacer()
        }
    }
}

struct PackItemEditScreen_Previews: PreviewProvider {
    static var previews: some View {
//        let packItem = PackItemViewModel(packItem: PackItem(context: PackItem.viewContext))
        let packItem = PackItem(context: PackItem.viewContext)
        PackItemEditScreen(packItem: packItem)
    }
}
