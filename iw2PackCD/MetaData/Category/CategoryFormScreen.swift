//
//  CategoryFormViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 29-Apr-22.
//

import SwiftUI

struct CategoryFormScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var categoryFormVM = CategoryFormViewModel()
    var body: some View {
        VStack {
            Text("Add a Category")
                .font(.title)
            Form {
                TextField("Category Name", text: $categoryFormVM.name)
                    .padding(.all, 10.0)
                
                HStack {
                    Button("Save") {
                        categoryFormVM.save()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(width: 80.0)
                    Spacer()
                    Button("Cancel") {
                        // TODO: This shouldn't save blank items.
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(width: 80.0)
                }
                .padding(.vertical)
            }
        }
    }
}

struct CategoryFormScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFormScreen()
    }
}
