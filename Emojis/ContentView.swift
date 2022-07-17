//
//  ContentView.swift
//  Emojis
//
//  Created by 田中大地 on 2022/07/17.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.Sample.Emojis"))
    var emojiData: Data = Data()
    
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
                    }
            }
        }
    }
    
    private func save(_ emoji: Emoji){
        guard let emojiData = try? JSONEncoder().encode(emoji) else { return }
        self.emojiData = emojiData
        print("saved Emoji: \(emoji)")
        print(dump(emoji))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
