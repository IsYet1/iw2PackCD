//
//  StartView.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 27-Apr-22.
//

import SwiftUI

struct StartView: View {

    @State private var selectedTab = UserDefaults.standard.integer(forKey: "startTab")
    
    var body: some View {
        TabView(selection: $selectedTab) {
            EventListScreen().tabItem {
                Label("Events", systemImage: "airplane.departure")
            }
            .tag(1)
            
            PackItemListScreen().tabItem {
                Label("Items", systemImage: "tshirt")
            }
            .tag(2)
            
            CategoryList().tabItem {
                Label("Categories", systemImage: "square.and.arrow.down.on.square")
            }
            .tag(3)
            
            LocationList().tabItem {
                Label("Locations", systemImage: "square.split.bottomrightquarter")
            }
            .tag(4)
            
            UtilitiesScreen().tabItem {
                Label("Utilities", systemImage: "rectangle.and.pencil.and.ellipsis")
            }
            .tag(0)
            
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
