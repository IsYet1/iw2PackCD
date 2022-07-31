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
            NavigationStackView().tabItem {
                Text("N")
            }
            EventListScreen().tabItem {
//                Text("Events")
                Label("Events", systemImage: "airplane.departure")
            }
            PackItemListScreen().tabItem {
//                Text("Items")
                Label("Items", systemImage: "tshirt")
            }
            CategoryList().tabItem {
//                Text("Categories")
                Label("Categories", systemImage: "square.and.arrow.down.on.square")
            }
            LocationList().tabItem {
//                Text("Locations")
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
