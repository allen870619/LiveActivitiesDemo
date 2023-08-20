//
//  ContentView.swift
//  ActivityKitDemo
//
//  Created by Allen Lee on 2023/8/13.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    let liveActivitiesManager: LiveActivitiesManager
    
    init(liveActivitiesManager: LiveActivitiesManager) {
        self.liveActivitiesManager = liveActivitiesManager
    }
    
    var body: some View {
        VStack {
            Button {
                // tap
                liveActivitiesManager.attach()
            } label: {
                Text("Attach live activities")
            }
            .padding()
            
            Button {
                // tap
                liveActivitiesManager.detach()
            } label: {
                Text("Detach live activities")
            }
            .padding()

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(liveActivitiesManager: LiveActivitiesManager())
    }
}
