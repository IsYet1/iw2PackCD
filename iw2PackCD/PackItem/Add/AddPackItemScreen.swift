//
//  AddPackItemScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 19-May-22.
//

import SwiftUI

struct AddPackItemScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var addPackItemVM = PackItemAddViewModel()
    
    var body: some View {
        Form {
            TextField("Enter Item Name", text: $addPackItemVM.name)
        }
        HStack {
            Spacer()
            Button("Save") {
                addPackItemVM.save()
                presentationMode.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

struct AddPackItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddPackItemScreen()
    }
}
