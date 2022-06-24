//
//  EventItemAddCell.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 24-Jun-22.
//

import SwiftUI

struct EventItemAddCell: View {
    @ObservedObject var packItem: PackItem
    
    var body: some View {
        var selected: Bool = false
        HStack {
            Toggle(
                packItem.name!,
                isOn: Binding<Bool> (
                    get: {return false},
                    set: {selected = $0 }
                )
            )
            .toggleStyle(CheckboxToggleStyle(style: .circle))
//            .foregroundColor(.blue)
        }
    }
}

//struct EventItemAddCell_Previews: PreviewProvider {
//    static var previews: some View {
//        EventItemAddCell()
//    }
//}
