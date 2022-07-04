//
//  EventItemAddCell.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 24-Jun-22.
//

import SwiftUI
import CoreData

struct EventItemAddCell: View {
    @State var eventItemEditVM: EventItemEditVM
    
    var body: some View {
        HStack {
            Toggle(
                eventItemEditVM.packItem.name!,
                isOn: Binding<Bool> (
                    get: {
                        return eventItemEditVM.itemIsInEvent
                    },
                    set: {
                        eventItemEditVM.addOrRemoveItemToEvent(addItem: $0)
                    }
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
