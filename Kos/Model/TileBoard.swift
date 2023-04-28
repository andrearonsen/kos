//
//  TileBoard.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import Foundation

struct TileBoard {
    let letters: [Character]
    let matrix: Matrix<TileCell>
    let words: [TileBoardWord]
    let rows: [TileRow]
    
    static func forBoard(b: Board) -> TileBoard {
        var tileMatrix: Matrix<TileCell> = Matrix(rows: b.nrRows(), columns: b.nrCols(), defaultValue: TileCell.empty)
        var rows: [TileRow] = []
        
        // Convert Board -> TileBoard
        for r in 0...b.matrix.rows-1 {
            var tiles: [TileCell] = []
            for c in 0...b.matrix.columns-1 {
                let tileCellId = r * 100 + c // Unique cell id in the matrix
                if b.isEmpty(row: r, col: c) {
                    let tile = Tile.empty
                    tileMatrix[r, c] = TileCell(id: tileCellId, tile: tile)
                } else {
                    let cell = b.matrix[r, c]
                    let tile = Tile(letter: cell, state: .hidden)
                    tileMatrix[r, c] = TileCell(id: tileCellId, tile: tile)
                }
                let cell = tileMatrix[r, c]
                tiles.append(cell)
            }
            rows.append(TileRow(id: r, tiles: tiles))
        }
        
        var words: [TileBoardWord] = []
        for wp in b.words {
            let tbw = collectTilesForWord(mat: tileMatrix, w: wp)
            words.append(tbw)
        }
        
        return TileBoard(letters: b.letters, matrix: tileMatrix, words: words, rows: rows)
    }
    
    static private func collectTilesForWord(mat: Matrix<TileCell>, w: WordPlacement) -> TileBoardWord {
        var tileCells: [TileCell] = []
        
        switch w.dir {
        case .Horizontal:
            let r = w.row
            let c = w.col
            for (i, letter) in w.word.enumerated() {
                let cell = mat[r, c+i]
                if cell.tile.hasLetter(l: letter) {
                    tileCells.append(cell)
                } else {
                    fatalError("Letter does not appear on the right spot in the row")
                }
            }
        case .Vertical:
            let r = w.row
            let c = w.col
            for (i, letter) in w.word.enumerated() {
                let cell = mat[r+i, c]
                if cell.tile.hasLetter(l: letter) {
                    tileCells.append(cell)
                } else {
                    fatalError("Letter does not appear on the right spot in the column")
                }
            }
        case .NotPossible:
            fatalError("Not possible should not be a part of a board")
        }
        
        return TileBoardWord(word: w.word, letterCells: tileCells, revealed: false)
    }
    
    func nrCols() -> Int {
        return matrix.columns
    }
    
    mutating func checkAndRevealWord(word: String) -> Bool {
        for var w in words {
            if w.word == word {
                
                // Reveal word in tiles
                if w.revealed {
                    return true
                } else {
                    print("Revealing \(word)")
                    w.reveal()
                }
                return true
            }
        }
        return false
    }
    
}

final class TileBoardWord : Identifiable {
    var id: String
    let word: String
    var letterCells: [TileCell]
    var revealed: Bool
    
    init(word: String, letterCells: [TileCell], revealed: Bool) {
        self.id = word
        self.word = word
        self.letterCells = letterCells
        self.revealed = revealed
    }

    func reveal() {
        if revealed {
            return
        }
        // TODO Slå opp i TileRows, fordi det er det som blir rendret
        for lc in letterCells {
            lc.reveal()
        }
        revealed = true
    }

}

final class TileCell: Identifiable {
    let id: Int
    var tile: Tile
    
    init(id: Int, tile: Tile) {
        self.id = id
        self.tile = tile
    }
    
    static let empty: TileCell = TileCell(id: 0, tile: Tile.empty)
    
    func reveal() {
        if tile.state == .hidden {
            tile.state = .revealed
        }
    }
    
    func revealed() -> TileCell {
        if tile.state == .hidden {
            return TileCell(id: id, tile: Tile(letter: tile.letter, state: .revealed))
        }
        return self
    }
}

struct TileRow: Identifiable {
    let id: Int
    let tiles: [TileCell]
}
