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
        Picker("", selection: $selectedLocation) {
            ForEach(locationsFR, id: \.self) {(location: Location ) in
                Text(location.name ?? "").tag(location as Location?)
            }
        }
        .pickerStyle(.wheel)
    }
}

//struct CategoryPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryPicker()
//    }
//}
