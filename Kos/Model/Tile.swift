//
//  Tile.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import Foundation

struct Tile {
    // TODO Revealed concept instead of isEmpty
    
    var character: String
    static let empty = Tile(character: "")
    static let A = Tile(character: "A")
    
    func isEmpty() -> Bool {
        return self.character.isEmpty
    }
}
