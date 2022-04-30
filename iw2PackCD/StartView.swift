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
            CategoryList().tabItem() {Text("Category")}
            LocationList().tabItem() {Text("Location")}
            ContentView().tabItem() {Text("Time Stamps")}
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
