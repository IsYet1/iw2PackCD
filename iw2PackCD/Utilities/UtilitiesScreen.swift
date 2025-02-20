//
//  HomePage.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 9/3/22.
//

import SwiftUI

struct UtilitiesScreen: View {
    @StateObject private var utilities = UtilitiesService()
    @State private var outputData = "Initial output data"
    
    var body: some View {
        VStack() {
            Text("Utilities").font(.largeTitle)
            Divider()
            
            VStack(alignment: .center){
                Text(outputData)
                
                Button("Add Sample Data", action: {
                    utilities.addSampleData()
                })
                .buttonStyle(.bordered)
                .disabled(false)
                
                Button("Remove Sample Data", action: {
                    utilities.removeSampleData()
                })
                .buttonStyle(.bordered)
                .disabled(false)
                
                Button("Startup on Events", action: {
                    utilities.startOnEvents()
                })
                .buttonStyle(.bordered)
                
                Button("Startup on Utilities", action: {
                    utilities.startOnUtilities()
                })
                .buttonStyle(.bordered)
                
                Button("Backup Data", action: {
                    outputData = utilities.backupData()
                })
                .buttonStyle(.bordered).disabled(true)
                
                Button("Restore Data", action: {
                    print("Restore Data")
                })
                .buttonStyle(.bordered).disabled(true)
                
            }
            .padding(20)
            
            Spacer()
        }
    }
}

struct UtilitiesScreen_Previews: PreviewProvider {
    static var previews: some View {
        UtilitiesScreen()
    }
}
