//
//  LiveActivityWidgetLiveActivity.swift
//  LiveActivityWidget
//
//  Created by Allen Lee on 2023/8/13.
//

import ActivityKit
import WidgetKit
import SwiftUI


struct LiveActivityWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
//        var value: Int
    }

    // Fixed non-changing properties about your activity go here!
    var title: String
    var subtitle: String
}

struct LiveActivityWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                HStack {
                    VStack{
                        Image(uiImage: .checkmark)
                    }.padding(4)
                    Text("Hello")
                }.padding()
                
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                    Color.white
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        Text("Bottom")
                            .foregroundColor(.white)
                            .frame(height: 600)
                            .padding()
                        
                    }.backgroundStyle(.red)
                }
            } compactLeading: {
                Text("Hello")
            } compactTrailing: {
                Text("World")
            } minimal: {
                Text("Min")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

struct LiveActivityWidgetLiveActivity_Previews: PreviewProvider {
    static let attributes = LiveActivityWidgetAttributes(title: "Hello", subtitle: "This is Allen")
    static let contentState = LiveActivityWidgetAttributes.ContentState()

    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Island Compact")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Island Expanded")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal")
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
