//
//  CategoryFormViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 29-Apr-22.
//

import SwiftUI

struct CategoryFormScreen: View {
    @StateObject private var categoryFormVM = CategoryFormViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Form {
            TextField("Category Name", text: $categoryFormVM.name)
            
            HStack {
                Spacer()
                Button("Save") {
                    categoryFormVM.save()
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
        }
    }
}

struct CategoryFormScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFormScreen()
    }
}
