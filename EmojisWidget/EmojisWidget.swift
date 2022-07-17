//
//  EmojisWidget.swift
//  EmojisWidget
//
//  Created by 田中大地 on 2022/07/17.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.Sample.Emojis"))
    var emojiData: Data = Data()
    
    func placeholder(in context: Context) -> SimpleEntry {
        guard let emoji = try? JSONDecoder().decode(Emoji.self,from: emojiData) else {
            return SimpleEntry(date: Date(), emoji: Emoji(icon: "💛", name: "N/A", description: "N/A"))
        }
        return SimpleEntry(date: Date(), emoji: emoji)
    }
  

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        guard let emoji = try? JSONDecoder().decode(Emoji.self,from: emojiData) else { return }
        let entry = SimpleEntry(date: Date(), emoji: emoji)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        guard let emoji = try? JSONDecoder().decode(Emoji.self,from: emojiData) else { return }
        var entries: [SimpleEntry] = []

        let entry = SimpleEntry(date: Date(), emoji: emoji)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: Emoji
}

struct EmojisWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        EmojiView(emoji: entry.emoji)
    }
}

@main
struct EmojisWidget: Widget {
    let kind: String = "EmojisWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            EmojisWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct EmojisWidget_Previews: PreviewProvider {
    static var previews: some View {
        EmojisWidgetEntryView(entry: SimpleEntry(date: Date(), emoji: Emoji(icon: "💛", name: "N/A", description: "N/A")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

