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
            PackItemListScreen().tabItem {
                Label("Items", systemImage: "tshirt")
            }
            EventListScreen().tabItem {
                Label("Events", systemImage: "airplane.departure")
            }
            CategoryList().tabItem {
                Label("Categories", systemImage: "square.and.arrow.down.on.square")
            }
            LocationList().tabItem {
                Label("Locations", systemImage: "square.split.bottomrightquarter")
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
