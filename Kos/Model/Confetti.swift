//
//  Confetti.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 01/05/2023.
//

import Foundation
import SwiftUI

struct ConfettiItem: Identifiable, Hashable {
    let id: Int
    let posX: CGFloat
    let text: String
    
    func speed() -> Double {
        return Double.random(in: 3...10)
    }
    
    func delay() -> Double {
        return Double.random(in: 0...2)
    }
}

struct ConfettiEmojis {
    static let stars: [String] = ["✨", "⭐", "🌟", "🤩", "💫"]
    static let hearts: [String] = ["❤️‍🔥", "🧡", "💗", "💓", "💔", "💚", "💝", "💜", "🫀", "🫶", "💑", "💞", "💛", "💕", "💘", "💖"]
    static let halloween: [String] = ["👻", "😱", "🎃", "🦇", "🕯️", "⚰️", "💀", "🕷️", "🕸️", "☠️", "😈"]
    static let level4: [String] = ["👻", "🎉", "😻", "🤠", "🥳", "✨", "🥰", "⭐"]
    static let level5: [String] = ["👻", "🎉", "😻", "🤠", "🥳", "✨", "🥰", "⭐"]
    static let level6: [String] = ["👻", "🎉", "😻", "🤠", "🥳", "✨", "🥰", "⭐"]
    static let level7: [String] = ["👻", "🎉", "😻", "🤠", "🥳", "✨", "🥰", "⭐"]
    static let level8: [String] = ["👻", "🎉", "😻", "🤠", "🥳", "✨", "🥰", "⭐"]
    static let level9: [String] = ["👻", "🎉", "😻", "🤠", "🥳", "✨", "🥰", "⭐"]
    static let level10: [String] = ["👻", "🎉", "😻", "🤠", "🥳", "✨", "🥰", "⭐"]
    
    static func emojisForLevel(level: Int) -> [String] {
        switch level % 10 {
        case 1: return stars
        case 2: return hearts
        case 3: return halloween
        default:
            return level4
        }
    }
}


func generateEmojis(emojis: [String], count: Int) -> [String] {
    let countEmojis = emojis.count
    
    var res: [String] = []
    for _ in 1...count {
        let r = Int.random(in: 0..<countEmojis)
        res.append(emojis[r])
    }
    
    return res
}

func createConfetti(level: Int) -> [ConfettiItem] {
    var cxs: [ConfettiItem] = []
    let countConfettiItems: Int = 50
    let emojis = generateEmojis(emojis: ConfettiEmojis.emojisForLevel(level: level), count: countConfettiItems)
    
    let offsetPerItem = UIScreen.main.bounds.width / CGFloat(countConfettiItems-1)
    let padding: CGFloat = 5
    
    for (i, e) in emojis.enumerated() {
        var posX = UIScreen.main.bounds.minX + offsetPerItem * CGFloat(i) + padding
        if posX > UIScreen.main.bounds.maxX {
            posX = UIScreen.main.bounds.maxX -  padding
        }
        cxs.append(ConfettiItem(
            id: i,
            posX: posX,
            text: String(e)
        ))
    }
    
    return cxs
}
