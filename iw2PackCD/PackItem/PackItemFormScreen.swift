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
    
    @State var selectedCategory: Category?
    
    @StateObject private var formVM = PackItemFormViewModel()
    
    var body: some View {
        VStack {
            Text("Add a Pack Item")
                .font(.title)
            TextField("Pack Item Name", text: $formVM.name)
                .padding(.all, 30.0)
            Picker("", selection: $selectedCategory) {
                ForEach(categories, id: \.self) {(category: Category ) in
                    Text(category.name!).tag(category as Category?)
                }
            }
            HStack {
                Button("Save") {
                    formVM.save(category: selectedCategory!)
                    presentationMode.wrappedValue.dismiss()
                }.padding()
//                Button("Cancel") {
//                    // TODO: This shouldn't save blank items.
//                    presentationMode.wrappedValue.dismiss()
//                }.padding()
            }
            .padding(.vertical)
            VStack {
                Text("Selected Category").font(.title)
                Text(selectedCategory?.name ?? "None Selected").font(.body)
            }
        }
        
    }
}

struct PackItemFormScreen_Previews: PreviewProvider {
    static var previews: some View {
        PackItemFormScreen()
    }
}

