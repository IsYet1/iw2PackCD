//
//  EventItemAddCell.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 24-Jun-22.
//

import SwiftUI
import CoreData

struct EventItemAddCell: View {
    @State var packItem: PackItem
    var currentEvent: Event
    
    var body: some View {
        var selected: Bool = false
        HStack {
            Toggle(
                packItem.name!,
                isOn: Binding<Bool> (
                    get: {
                        // TODO: This could be streamlined
                        let packItemEventIds = packItem.getEventIdsForPackItem(packItem: packItem)
                        return packItemEventIds.contains(currentEvent.id)
                    },
                    set: {
                        selected = $0
                        if (selected) {
                            EventItem.addEventItem(event: currentEvent, item: packItem)
                            
                        } else {
                            EventItem.deletePackItemFromEvent(event: currentEvent, packItem: packItem )
                        }
                    }
                )
            )
            .toggleStyle(CheckboxToggleStyle(style: .circle))
            //            .foregroundColor(.blue)
        }
    }
//    func updatePackItem () {
//        let request: NSFetchRequest<PackItem> = PackItem.fetchRequest()
//        request.predicate = NSPredicate(format: "%K = %@", #keyPath(PackItem.id), packItem.id)
//    }
}

//struct EventItemAddCell_Previews: PreviewProvider {
//    static var previews: some View {
//        EventItemAddCell()
//    }
//}
