//
//  iw2PackCDApp.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 25-Apr-22.
//

import SwiftUI

@main
struct iw2PackCDApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            StartView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
