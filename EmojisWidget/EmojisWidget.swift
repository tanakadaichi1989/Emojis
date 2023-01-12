//
//  EmojisWidget.swift
//  EmojisWidget
//
//  Created by 田中大地 on 2022/07/17.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), emoji: Emoji(icon: "💛", name: "N/A", description: "N/A"))
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let userDefaults = UserDefaults(suiteName: "group.sample.Emojis")!
        let date = Date()
        let emojiData = userDefaults.object(forKey: "Emoji") ?? Data()
        guard let emoji = try? JSONDecoder().decode(Emoji.self,from: emojiData as! Data) else {
            let entry = SimpleEntry(date: date, emoji: Emoji(icon: "💛", name: "N/A", description: "N/A"))
            let timeline = Timeline(entries: [entry], policy: .never)
            completion(timeline)
            return
        }
        let entry = SimpleEntry(date: date, emoji: emoji)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), emoji: Emoji(icon: "💛", name: "N/A", description: "N/A"))
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: Emoji
}

struct EmojisWidgetEntryView : View {
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var entry: Provider.Entry

    var body: some View {
        EmojisWidgetSmallView(emoji: entry.emoji)
    }
}

struct EmojisWidgetSmallView : View {
    var emoji: Emoji
    var body: some View {
        EmojiView(emoji: emoji)
    }
}

struct EmojisWidgetMediumView : View {
    var emoji: Emoji
    var body: some View {
        HStack {
            EmojiView(emoji: emoji)
            Text(emoji.name)
        }
    }
}

struct EmojisWidgetLargeView : View {
    var emoji: Emoji
    var body: some View {
        HStack {
            EmojiView(emoji: emoji)
            VStack(alignment: .leading){
                Text(emoji.name)
                Text(emoji.description)
            }
        }
    }
}

@main
struct EmojisWidget: Widget {
    let kind: String = "EmojisWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Emojis_Widget", provider: Provider()) { entry in
            EmojisWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Emojis Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall,.systemMedium,.systemLarge,.systemExtraLarge])
    }
}

struct EmojisWidget_Previews: PreviewProvider {
    static var previews: some View {
        EmojisWidgetEntryView(entry: SimpleEntry(date: Date(), emoji: Emoji(icon: "💛", name: "N/A", description: "N/A")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

