//
//  CategoryPicker.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 21-May-22.
//

import SwiftUI

struct LocationPicker: View {
    @Binding var selectedLocation: Location?
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.name, ascending: true)]
    )
    private var locationsFR: FetchedResults<Location>
    
    var body: some View {
        HStack {
            Text("Location").font(.headline).frame(width: 100)
            Picker("", selection: $selectedLocation) {
                Text("Select Location").tag(nil as Location?)
                ForEach(locationsFR, id: \.self) {(location: Location ) in
                    Text(location.name ?? "").tag(location as Location?)
                }
            }
            .pickerStyle(.menu)
            Spacer()
        }
    }
}

//struct CategoryPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryPicker()
//    }
//}
