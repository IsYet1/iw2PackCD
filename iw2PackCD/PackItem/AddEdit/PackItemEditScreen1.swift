//
//  PackItemEditScreen1.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 24-May-22.
//

import SwiftUI

struct PackItemEditScreen1: View {
    
    @State private var formItemName: String
    @State private var formItemCategoryName: String
    @State private var formItemCategory: Category?
    @State private var editItemVMForSave: PackItemEditVM
    
    init(editItemVM: PackItemEditVM) {
        formItemName = editItemVM.vmName
        formItemCategoryName = editItemVM.vmCategory.name ?? "active"
        formItemCategory = editItemVM.vmPackItem.category!
        editItemVMForSave = editItemVM
    }
    
    var body: some View {
        VStack {
            Text(formItemName)
            Text(formItemCategoryName)
            
            TextField("Item Name", text: $formItemName)
                .padding(.leading, 20.0)
                .padding(.trailing, 20.0)
                .textFieldStyle(.roundedBorder)
            HStack {
//                Text(formItemCategory!.name!)
                Spacer()
            }.padding(.leading, 30.0)
                .font(.caption)
            CategoryPicker(selectedCategory: $formItemCategory)
            HStack {
                Button("Save") {
                    editItemVMForSave.vmName = formItemName
                    editItemVMForSave.vmCategory = formItemCategory!
                    editItemVMForSave.save()
                }
                .padding()
                .buttonStyle(.bordered)
            }
        }
    }
}

//struct PackItemEditScreen1_Previews: PreviewProvider {
//    static var previews: some View {
//        PackItemEditScreen1()
//    }
//}
