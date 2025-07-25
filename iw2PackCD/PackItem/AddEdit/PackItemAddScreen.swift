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
    @State var selectedLocation: Location?
    
    @State private var packItemName = ""
    
    // TODO: Can this be simplified? Only need to check for empty data.
    @FetchRequest( sortDescriptors: [] )
    private var categories: FetchedResults<Category>
    @FetchRequest( sortDescriptors: [] )
    private var locations: FetchedResults<Location>
    
    var body: some View {
        if(categories.count == 0 || locations.count == 0) {
            VStack {
                Spacer()
                Text("Please add at least one Category and one Location before adding Items.")
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }.padding()
                    .buttonStyle(.bordered)
                Spacer()
            }
        } else {
            VStack {
                Text("Add a Pack Item").font(.title)
                TextField("Pack Item Name", text: $packItemName)
                    .padding([.leading, .trailing], 20.0)
                    .textFieldStyle(.roundedBorder)
                
                CategoryPicker(selectedCategory: $selectedCategory)
                LocationPicker(selectedLocation: $selectedLocation)
                
                HStack {
                    Button("Save") {
                        PackItem.addPackItem(name: packItemName, category: selectedCategory!, location: selectedLocation!)
                        packItemName = ""
                    }.padding()
                        .buttonStyle(.bordered)
                        .disabled(selectedCategory == nil || selectedLocation == nil || packItemName.isEmpty)
                    
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }.padding()
                        .buttonStyle(.bordered)
                }
            }
        }
        Spacer()
    }
}

struct PackItemAddScreen_Previews: PreviewProvider {
    static var previews: some View {
        PackItemAddScreen()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

