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
    @FocusState private var focusTextField: Bool
    
    
    init(packItem: PackItem, editItemVM: PackItemEditVM) {
        itemName = packItem.packItemName
        category = packItem.packItemCategory
        formPackItem = packItem
        selectedCategory = editItemVM.vmCategory // packItem.category
        focusTextField = true
    }
    
    @State private var packItemName = ""
    var body: some View {
        VStack {
            TextField("Item Name", text: $itemName)
                .padding(.leading, 20.0)
                .padding(.trailing, 20.0)
                .focused($focusTextField)
                .textFieldStyle(.roundedBorder)
            HStack {
                Text(category.name!)
                Spacer()
            }.padding(.leading, 30.0)
                .font(.caption)
            CategoryPicker(selectedCategory: $selectedCategory)
            HStack {
                Button("Save") {
                    let editItemVM = PackItemEditVM(packItemIn: formPackItem)
                    editItemVM.vmName = itemName
                    editItemVM.vmCategory = selectedCategory!
                    editItemVM.save()
                }.padding()
//                Button("Cancel") {
//                    // TODO: This shouldn't save blank items.
//                    presentationMode.wrappedValue.dismiss()
//                }.padding()
            }
        }
        Spacer()
    }
}

//struct PackItemEditScreen_Previews: PreviewProvider {
//    static var previews: some View {
////        let packItem = PackItemViewModel(packItem: PackItem(context: PackItem.viewContext))
//        let packItem = PackItem(context: PackItem.viewContext)
//        PackItemEditScreen(packItem: packItem)
//    }
//}
