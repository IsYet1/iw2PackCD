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
                "",
                isOn: Binding<Bool> (
                    get: {
                        return eventItemListCellVM.itemStaged
                    },
                    set: {
                        eventItemListCellVM.updatePackedStatus(checked: $0, phase: .staged)
                    }
                )
            )
            .toggleStyle(CheckboxToggleStyle(style: .circle))
                            .foregroundColor(.blue)
            Toggle(
                eventItemListCellVM.packItemName,
                isOn: Binding<Bool> (
                    get: {
                        return eventItemListCellVM.itemPacked
                    },
                    set: {
                        eventItemListCellVM.updatePackedStatus(checked: $0, phase: .packed)
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
