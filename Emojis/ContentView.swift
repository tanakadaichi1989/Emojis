//
//  ContentView.swift
//  Emojis
//
//  Created by 田中大地 on 2022/07/17.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @AppStorage("emojiData") var emojiData: Data = Data()
    
    let emojis = [
        Emoji(icon: "😃", name: "大きい目の笑顔", description: "grinning face with big eyes"),
        Emoji(icon: "🏂", name: "スノーボーダー", description: "snowboarder"),
        Emoji(icon: "🦄", name: "ユニコーン", description: "unicorn")
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
        userDefaults.set(emoji.icon, forKey: "Emoji")
        print("saved Emoji: \(emoji)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
