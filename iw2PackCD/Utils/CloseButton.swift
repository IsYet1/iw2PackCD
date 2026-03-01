//
//  CloseButton.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 26-Jun-22.
//

import SwiftUI


struct CloseButton: View {
    @Environment(\.presentationMode) var presentationMode
    let title: String
    init(title: String = "Close") {
        self.title = title
    }
    var body: some View {
        HStack {
            Button(title) {
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

