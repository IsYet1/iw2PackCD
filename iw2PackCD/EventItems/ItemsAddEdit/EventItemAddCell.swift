//
//  EventItemAddCell.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 24-Jun-22.
//

import SwiftUI
import CoreData


enum EventItemCellType {
    case item
    case event
}

struct EventItemAddCell: View {
    @StateObject var eventItemEditVM: EventItemEditVM
    var eventItemCellType: EventItemCellType
    
    var body: some View {
        HStack {
            Toggle(
                eventItemCellType == .event ? eventItemEditVM.packItem.name! : eventItemEditVM.event.name!,
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
