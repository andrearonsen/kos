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
        let matrix: Matrix<TileCell> = Matrix(rows: b.nrRows(), columns: b.nrCols(), defaultValue: TileCell.empty)
        // TODO Place words and make sure all tile cells has ids
        let rows: [TileRow] = rows(mat: matrix)
        let words: [TileBoardWord] = []
        return TileBoard(letters: b.letters, matrix: matrix, words: words, rows: rows)
    }
    
    static private func rows(mat: Matrix<TileCell>) -> [TileRow] {
        var rows: [TileRow] = []
        for r in 0...mat.rows-1 {
            var tiles: [TileCell] = []
            for c in 0...mat.columns-1 {
                var cell = mat[r, c]
                tiles.append(cell)
            }
            rows.append(TileRow(id: r, tiles: tiles))
        }
        return rows
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
