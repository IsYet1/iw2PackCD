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
            EventListScreen().tabItem() {Text("Events")}
            PackItemListScreen().tabItem() {Text("Pack Items VM")}
            CategoryList().tabItem() {Text("Category")}
//            LocationList().tabItem() {Text("Location")}
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
