//
//  PackItemFormScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 07-May-22.
//

import SwiftUI

struct EventItemAddScreen: View {
    let event: Event
    
    @StateObject private var packItemListVm = PackItemListVM()
    
    var body: some View {
        VStack {
            CloseButton()
            Divider()
            Text("Add Items To: \(event.name!)").font(.title)
            Divider()
            
            List {
                ForEach(packItemListVm.groupedSortedFiltered, id:\.key) {sections in
                    Section(header: Text(sections.key)) {
                        ForEach(sections.value, id: \.packItemId) {item in
                            EventItemAddCell(
                                eventItemEditVM: EventItemEditVM(packItemIn: item.packItem, eventIn: event)
                            )
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            packItemListVm.getAllPackItems()
        })
        Spacer()
    }
}

//struct PackItemFormScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PackItemAddScreen()
//    }
//}


