//
//  Emoji.swift
//  Emojis
//
//  Created by 田中大地 on 2022/07/17.
//

import Foundation

struct Emoji: Identifiable, Codable {
    let icon: String
    let name: String
    let description: String
    
    var id: String { icon }
}
