//
//  TileBoardWord.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 29/04/2023.
//

import Foundation

struct TileBoardWord : Identifiable {
    let id: String
    let word: String
    let letterCells: [TileIndex]
    let revealed: Bool
    
    init(word: String, letterCells: [TileIndex], revealed: Bool) {
        self.id = word
        self.word = word
        self.letterCells = letterCells
        self.revealed = revealed
    }
    
    func reveal() -> TileBoardWord {
        return TileBoardWord(word: word, letterCells: letterCells, revealed: true)
    }
    
    func containsTileCell(tileCell: TileCell) -> Bool {
        return letterCells.contains(where: { lc in
            tileCell.hasIndex(index: lc)
        })
    }
}

struct TileIndex {
    let row: Int
    let col: Int
}

