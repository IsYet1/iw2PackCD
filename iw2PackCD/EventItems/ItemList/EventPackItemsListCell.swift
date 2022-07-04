//
//  EventPackItemsListCell.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 04-Jul-22.
//

import SwiftUI
import CoreData

struct EventPackItemsListCell: View {
    @StateObject var eventItemListCellVM: EventItemListCellVM

    var body: some View {
        HStack {
            Toggle(
                eventItemListCellVM.packItemName,
                isOn: Binding<Bool> (
                    get: {
                        return eventItemListCellVM.itemPacked
                    },
                    set: {
                        eventItemListCellVM.updatePackedStatus(packed: $0)
                    }
                )
            )
            .toggleStyle(CheckboxToggleStyle(style: .square))
            //            .foregroundColor(.blue)
        }
    }
}

//struct EventPackItemsListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        EventPackItemsListCell()
//    }
//}
