//
//  ActivityKitDemoApp.swift
//  ActivityKitDemo
//
//  Created by Allen Lee on 2023/8/13.
//

import SwiftUI
import ActivityKit
import LiveActivityWidgetExtension

@main
struct ActivityKitDemoApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    let liveActivitiesManager = LiveActivitiesManager()
    
    init() {
        appDelegate.liveActivitiesManager = self.liveActivitiesManager
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(liveActivitiesManager: LiveActivitiesManager())
        }.onChange(of: scenePhase) { phase in
//            switch scenePhase {
//            case .background:
//                print("background")
//            case .inactive:
//                print("inactive")
//            case .active:
//                print("active")
//            @unknown default:
//                print("unknown")
//            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    weak var liveActivitiesManager: LiveActivitiesManager?
    
    func applicationWillTerminate(_ application: UIApplication) {
        // 在App被關閉時執行的功能
        print(#function)
        print(liveActivitiesManager)
        liveActivitiesManager?.detach()
        
    }
    
    func yourFunction() {
        
    }
}


class LiveActivitiesManager {
    private var deliveryActivity: Activity<LiveActivityWidgetAttributes>?
    
    func attach() {
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            setupActivity()
            // Add code to start the Live Activity here.
            // ...
        }
    }
    
    func detach() {
        Task {
            for activity in Activity<LiveActivityWidgetAttributes>.activities {
                print("detach: \(activity)")
                await activity.end(.init(state: .init(), staleDate: .now), dismissalPolicy: .default)
            }
        }
    }
    
    private func setupActivity() {
        let initialContentState = LiveActivityWidgetAttributes.ContentState()
        let activityAttributes = LiveActivityWidgetAttributes(title: "title", subtitle: "subtitle")
        
        let activityContent = ActivityContent(state: initialContentState, staleDate: Calendar.current.date(byAdding: .minute, value: 30, to: Date())!)
        
        do {
            deliveryActivity = try Activity.request(attributes: activityAttributes, content: activityContent)
            print("subscribe success.")
        } catch (let error) {
            print(error.localizedDescription)
        }
        
    }
}
