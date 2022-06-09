//
//  CategoryFormViewModel.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 30-Apr-22.
//

import Foundation
import CoreData

class EventFormViewModel: ObservableObject {
    var name: String = ""
    
    func save() {
        let event = Event(context: Event.viewContext)
        event.name = name
        
        try? event.save()
    }
}
