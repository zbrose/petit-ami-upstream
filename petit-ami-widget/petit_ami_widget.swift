//
//  petit_ami_widget.swift
//  petit-ami-widget
//
//  Created by Zach Brose on 4/15/22.
//

import WidgetKit
import SwiftUI


struct Provider: TimelineProvider {
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), image: UIImage(named: "Still")!)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(),image: UIImage(named: "Still")! )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, image: UIImage(named: "Still")!)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: UIImage
}

struct petit_ami_widgetEntryView : View {

    var entry: Provider.Entry
    
    var body: some View {
        VStack{
            Image("Still")
                    .resizable()
                    .scaledToFill()
        }
    }
}

@main
struct petit_ami_widget: Widget {
    let kind: String = "petit_ami_widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            petit_ami_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct petit_ami_widget_Previews: PreviewProvider {
    static var previews: some View {
        petit_ami_widgetEntryView(entry: SimpleEntry(date: Date(),image: UIImage(named: "Still")!))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
