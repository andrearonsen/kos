//
//  Tile.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import Foundation

struct Tile {
    enum State: CaseIterable {
        case empty
        case hidden
        case revealed
    }
    
    let letter: String
    var state: State
    
    // TODO Immutable state?
    mutating func reveal() {
        if state == .hidden {
            state = .revealed
        }
    }
    
    func hasLetter(l: Character) -> Bool {
        return String(l) == letter
    }
    
    static let empty = Tile(letter: "", state: .empty)
    
    // For testing
    static let WHidden = Tile(letter: "W", state: .hidden)
    static let WRevealed = Tile(letter: "W", state: .revealed)
}
