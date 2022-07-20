//
//  LocationList.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 27-Apr-22.
//

import SwiftUI

struct LocationList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showForm: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Location>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    LocationItemCell(item: item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Locations")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        self.showForm = true
                    }
                }
            }
            .sheet(isPresented: $showForm, content: {
                LocationFormScreen()
            })
            Text("Select an item")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct LocationList_Previews: PreviewProvider {
    static var previews: some View {
        LocationList()
    }
}

struct LocationItemCell: View {
    let item: Location
    var body: some View {
        NavigationLink {
            LocationPackItemsList(location: item)
            Text("Item at \(item.name!)")
        } label: {
            Text(item.name!)
        }
    }
}
