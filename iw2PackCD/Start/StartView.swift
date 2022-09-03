//
//  StartView.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 27-Apr-22.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        TabView {
            EventListScreen().tabItem {
                Label("Events", systemImage: "airplane.departure")
            }
            PackItemListScreen().tabItem {
                Label("Items", systemImage: "tshirt")
            }
            CategoryList().tabItem {
                Label("Categories", systemImage: "square.and.arrow.down.on.square")
            }
            LocationList().tabItem {
                Label("Locations", systemImage: "square.split.bottomrightquarter")
            }
            HomeScreen().tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
