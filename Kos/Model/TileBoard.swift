//
//  TileBoard.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import Foundation

struct TileBoardWord {
    let word: String
    var letterCells: [TileCell]
    var revealed: Bool
    
    mutating func reveal() {
        if revealed {
            return
        }
        for var lc in letterCells {
            lc.tile.reveal()
        }
        revealed = true
    }
}

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
            var r = w.row
            var c = w.col
            for (i, letter) in w.word.enumerated() {
                var cell = mat[r, c+i]
                if cell.tile.hasLetter(l: letter) {
                    tileCells.append(cell)
                } else {
                    fatalError("Letter does not appear on the right spot in the row")
                }
            }
        case .Vertical:
            var r = w.row
            var c = w.col
            for (i, letter) in w.word.enumerated() {
                var cell = mat[r+i, c]
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
}

struct TileCell: Identifiable {
    let id: Int
    var tile: Tile
    
    static let empty: TileCell = TileCell(id: 0, tile: Tile.empty)
}

struct TileRow: Identifiable {
    let id: Int
    let tiles: [TileCell]
}
