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
    @StateObject private var categoryListVM = CategoryListVM()
    
    @State var selectedCategory: Category?
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)]
//    )
//    private var categories: FetchedResults<Category>
    
    var body: some View {
        Form {
            TextField("Pack Item Name", text: $addPackItemVM.name)
                .padding(.all, 30.0)
            Picker("", selection: $selectedCategory) {
                ForEach($categoryListVM.categories, id: \.categoryId) {($category) in
//                    Text(category.name).tag(category)
                }
            }
        }
        HStack {
            Spacer()
            Button("Save") {
//                addPackItemVM.save()
                presentationMode.wrappedValue.dismiss()
            }
            Spacer()
        }
        .onAppear(perform: {
            categoryListVM.getAllCategories()
        })
    }
}

struct AddPackItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddPackItemScreen()
    }
}
