//
//  PackItemFormScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import SwiftUI

struct PackItemFormScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)]
    )
    private var categories: FetchedResults<Category>
    
    @StateObject private var formVM = PackItemFormViewModel()
    @State private var selectedCategory = "Test"
    
    var body: some View {
        VStack {
            Text("Add a Pack Item")
                .font(.title)
            TextField("Pack Item Name", text: $formVM.name)
                .padding(.all, 30.0)
            Picker("Category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) {(category ) in
                    Text(category.name!)
                }
            }
            HStack {
                Button("Save") {
                    formVM.save()
                    presentationMode.wrappedValue.dismiss()
                }.padding()
                Button("Cancel") {
                    // TODO: This shouldn't save blank items.
                    presentationMode.wrappedValue.dismiss()
                }.padding()
            }
            .padding(.vertical)
        }
    }
}

struct PackItemFormScreen_Previews: PreviewProvider {
    static var previews: some View {
        PackItemFormScreen()
    }
}

