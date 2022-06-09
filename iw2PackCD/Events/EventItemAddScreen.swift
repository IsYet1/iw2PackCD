//
//  PackItemFormScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import SwiftUI

struct EventItemAddScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var packItemName = ""
    
    var body: some View {
        VStack {
            Text("Add a Pack Item").font(.title)
            TextField("Pack Item Name", text: $packItemName)
                .padding([.leading, .trailing], 20.0)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Button("Save") {
//                    PackItem.addPackItem(name: packItemName, category: selectedCategory!)
                    presentationMode.wrappedValue.dismiss()
                }.padding()
                .buttonStyle(.bordered)
            }
        }
        Spacer()
    }
}

//struct PackItemFormScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PackItemAddScreen()
//    }
//}

