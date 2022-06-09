//
//  CategoryFormViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 29-Apr-22.
//

import SwiftUI

struct EventFormScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var formVM = EventFormViewModel()
    
    var body: some View {
        VStack {
            Text("Add an Event")
                .font(.title)
            Form {
                TextField("Event Name", text: $formVM.name)
                    .padding(.all, 10.0)
                
                HStack {
                    Button("Save") {
                        formVM.save()
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

struct EventFormScreen_Previews: PreviewProvider {
    static var previews: some View {
        EventFormScreen()
    }
}
