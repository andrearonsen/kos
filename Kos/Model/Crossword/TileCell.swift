//
//  TileCell.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 29/04/2023.
//

import Foundation

enum TileCellState: CaseIterable {
    case empty
    case hidden
    case revealed
}

struct TileCell: Identifiable, Equatable {
    let row: Int
    let col: Int
    let id: Int
    let letter: String
    let state: TileCellState
    
    init(row: Int, col: Int, letter: String, state: TileCellState) {
        self.row = row
        self.col = col
        self.id = row * 100 + col // Unique id in the matrix
        self.letter = letter
        self.state = state
    }
    
    func hasLetter(l: Character) -> Bool {
        return String(l) == letter
    }
    
    static func empty(row: Int, col: Int) -> TileCell {
        return TileCell(row: row, col: col, letter: "", state: .empty)
    }
    
    func isRevealed() -> Bool {
        return state == .revealed
    }

    func revealed() -> TileCell {
        if state == .hidden {
            return TileCell(row: row, col: col, letter: letter, state: .revealed)
        }
        return self
    }
}
