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
    
    let character: String
    var state: State
    
    // TODO Immutable state?
    mutating func reveal() {
        if state == .hidden {
            state = .revealed
        }
    }
    
    static let empty = Tile(character: "", state: .empty)
    
    // For testing
    static let WHidden = Tile(character: "W", state: .hidden)
    static let WRevealed = Tile(character: "W", state: .revealed)
}

struct TileCell: Identifiable {
    let id: Int
    let tile: Tile
}

struct TileRow: Identifiable {
    let id: Int
    let tiles: [TileCell]
}
