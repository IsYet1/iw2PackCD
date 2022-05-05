//
//  LocationFormScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 05-May-22.
//

import SwiftUI

struct LocationFormScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var locationFormVM = LocationFormViewModel()
    
    var body: some View {
        VStack {
            Text("Add a Location")
                .font(.title)
            Form {
                TextField("Location Name", text: $locationFormVM.name)
                    .padding(.all, 10.0)
                
                HStack {
                    Button("Save") {
                        locationFormVM.save()
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

struct LocationFormScreen_Previews: PreviewProvider {
    static var previews: some View {
        LocationFormScreen()
    }
}
