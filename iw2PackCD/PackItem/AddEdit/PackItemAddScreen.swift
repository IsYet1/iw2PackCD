//
//  PackItemFormScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import SwiftUI

struct PackItemAddScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectedCategory: Category?
    
    @StateObject private var packItemFormVM = PackItemAddVM(packItemIn: nil)
    
    var body: some View {
        VStack {
            Text("Add a Pack Item")
                .font(.title)
            TextField("Pack Item Name", text: $packItemFormVM.name)
                .padding(.all, 30.0)
            CategoryPicker(selectedCategory: $selectedCategory)
            HStack {
                Button("Save") {
                    packItemFormVM.save(category: selectedCategory!)
                    presentationMode.wrappedValue.dismiss()
                }.padding()
                // TODO: Add a cancel button
            }
            .padding(.vertical)
            VStack {
                Text("Selected Category").font(.title)
                Text(selectedCategory?.name ?? "None Selected").font(.body)
            }
        }
        
    }
}

//struct PackItemFormScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PackItemAddScreen()
//    }
//}

