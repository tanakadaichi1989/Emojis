//
//  ContentView.swift
//  Emojis
//
//  Created by 田中大地 on 2022/07/17.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    let emojis = [
        Emoji(icon: "😃", name: "大きい目の笑顔", description: "Grinning face with big eyes"),
        Emoji(icon: "🏂", name: "スノーボーダー", description: "Snowboarder"),
        Emoji(icon: "🦄", name: "ユニコーン", description: "Unicorn")
    ]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 30){
            ForEach(emojis){ emoji in
                EmojiView(emoji: emoji)
                    .onTapGesture {
                        save(emoji)
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
        }
    }
    
    private func save(_ emoji: Emoji){
        let userDefaults = UserDefaults(suiteName: "group.sample.Emojis")!
        guard let emojiData = try? JSONEncoder().encode(emoji) else { return }
        userDefaults.set(emojiData, forKey: "Emoji")
        print("saved Emoji: \(emoji)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
