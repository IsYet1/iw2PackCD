//
//  PackItemEditScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 16-May-22.
//

import SwiftUI

struct PackItemEditScreen: View {
//    let packItem: PackItem
//    let packItem: PackItemViewModel
    @State private var itemName: String
    @State private var category: Category
    @State private var formPackItem: PackItem
    @State var selectedCategory: Category?
    
    
    init(packItem: PackItem) {
        itemName = packItem.packItemName
        category = packItem.packItemCategory
        formPackItem = packItem
    }
    
    @State private var packItemName = ""
    var body: some View {
        VStack {
            TextField("Item Name", text: $itemName)
            CategoryPicker(selectedCategory: $selectedCategory)
            HStack {
                Button("Save") {
                    let vmForSave = PackItemAddViewModel(packItemIn: formPackItem)
                    vmForSave.name = itemName
                    vmForSave.save(category: selectedCategory!)
                }.padding()
//                Button("Cancel") {
//                    // TODO: This shouldn't save blank items.
//                    presentationMode.wrappedValue.dismiss()
//                }.padding()
            }
//            Spacer()
            Text(itemName) // packItemName)
            Text(category.name!) // packItemName)
        }
    }
}

//struct PackItemEditScreen_Previews: PreviewProvider {
//    static var previews: some View {
////        let packItem = PackItemViewModel(packItem: PackItem(context: PackItem.viewContext))
//        let packItem = PackItem(context: PackItem.viewContext)
//        PackItemEditScreen(packItem: packItem)
//    }
//}
