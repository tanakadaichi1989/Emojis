//
//  EmojiView.swift
//  Emojis
//
//  Created by 田中大地 on 2022/07/17.
//

import SwiftUI

struct EmojiView: View {
    let emoji: Emoji
    var body: some View {
        Text(emoji.icon)
            .font(.largeTitle)
            .padding()
            .background(Color.purple)
            .clipShape(Circle())
    }
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView(emoji: Emoji(icon: "🦄", name: "ユニコーン", description: "Unicorn"))
    }
}
