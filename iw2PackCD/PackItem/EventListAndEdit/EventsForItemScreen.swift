//
//  EventsForItemScreen.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 8/21/22.
//

import SwiftUI

struct EventsForItemScreen: View {
    @StateObject var editItemVM: PackItemEditVM
    
    var body: some View {
        VStack {
            Text("This Item is in in \(editItemVM.itemEvents.count) Events").font(.title)
            List {
                ForEach(editItemVM.allItemEvents, id: \.id) { itemEvent in
                    Toggle(
                        itemEvent.eventName,
                        isOn: Binding<Bool> (
                            get: {
                                return itemEvent.itemIsInEvent // true //eventItemEditVM.itemIsInEvent
                            },
                            set: {
                                print("Setting", $0)
                            }
                        )
                    )
                    .toggleStyle(CheckboxToggleStyle(style: .circle))
                }
            }
        }
    }
}

//struct EventsForItemScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        EventsForItemScreen()
//    }
//}
