//
//  CloseButton.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 26-Jun-22.
//

import SwiftUI


struct CloseButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        HStack {
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }.padding()
                .buttonStyle(.bordered)
        }
    }
    
}
struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton()
    }
}
