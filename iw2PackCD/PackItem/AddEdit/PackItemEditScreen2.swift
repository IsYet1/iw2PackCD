//
//  PackItemEditScreen2.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 25-May-22.
//

import SwiftUI

struct PackItemEditScreen2: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var editItemVM: PackItemEditVM
    
    var body: some View {
        VStack {
            Text("Edit a Pack Item").font(.title)
            TextField("Item Name", text: $editItemVM.vmName)
                .padding([.leading, .trailing], 20.0)
                .textFieldStyle(.roundedBorder)
            
            CategoryPicker(selectedCategory: $editItemVM.vmCategory)
            LocationPicker(selectedLocation: $editItemVM.vmLocation)
            
            Spacer()
            
            HStack {
                Button("Save") {
                    editItemVM.save()
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .buttonStyle(.bordered)
            }
        }
    }
}

//struct PackItemEditScreen2_Previews: PreviewProvider {
//    static var previews: some View {
//        PackItemEditScreen2()
//    }
//}
