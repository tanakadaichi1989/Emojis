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
        HStack {
            Text(emoji.icon)
                .font(.largeTitle)
                .padding()
                .background(Color.purple)
            .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(emoji.name)
                    .font(.title)
                    .fontWeight(.black)
                Text(emoji.description)
                    .font(.subheadline)
            }
        }
    }
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView(emoji: Emoji(icon: "🦄", name: "ユニコーン", description: "Unicorn"))
    }
}
