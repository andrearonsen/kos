//
//  TileBoard.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import Foundation

struct TileBoard {
    let letters: [Character]
    var rows: [TileRow]
    let nrCols: Int
    var words: [String: TileBoardWord]

    static func forBoard(b: Board) -> TileBoard {
        var tileMatrix: Matrix<TileCell> = Matrix(rows: b.nrRows(), columns: b.nrCols(), defaultValue: TileCell.empty(row: 0, col: 0))
        var rows: [TileRow] = []
        
        // Convert Board -> TileBoard
        for r in 0...b.matrix.rows-1 {
            var tiles: [TileCell] = []
            for c in 0...b.matrix.columns-1 {
                if b.isEmpty(row: r, col: c) {
                    tileMatrix[r, c] = TileCell(row: r, col: c, letter: "", state: .empty)
                } else {
                    let cell = b.matrix[r, c]
                    tileMatrix[r, c] = TileCell(row: r, col: c, letter: cell, state: .hidden)
                }
                let cell = tileMatrix[r, c]
                tiles.append(cell)
            }
            rows.append(TileRow(id: r, tiles: tiles))
        }
        
        var words: [String: TileBoardWord] = [:]
        for wp in b.words {
            words[wp.word] = collectTilesForWord(mat: tileMatrix, w: wp)
        }
        
        return TileBoard(letters: b.letters, rows: rows, nrCols: b.nrCols(), words: words)
    }
    
    static private func collectTilesForWord(mat: Matrix<TileCell>, w: WordPlacement) -> TileBoardWord {
        var tiles: [TileIndex] = []
        
        switch w.dir {
        case .Horizontal:
            let r = w.row
            let c = w.col
            for (i, letter) in w.word.enumerated() {
                let cell = mat[r, c+i]
                if cell.hasLetter(l: letter) {
                    tiles.append(TileIndex(row: r, col: c+i))
                } else {
                    fatalError("Letter does not appear on the right spot in the row")
                }
            }
        case .Vertical:
            let r = w.row
            let c = w.col
            for (i, letter) in w.word.enumerated() {
                let cell = mat[r+i, c]
                if cell.hasLetter(l: letter) {
                    tiles.append(TileIndex(row: r+i, col: c))
                } else {
                    fatalError("Letter does not appear on the right spot in the column")
                }
            }
        case .NotPossible:
            fatalError("Not possible should not be a part of a board")
        }
        
        return TileBoardWord(word: w.word, letterCells: tiles, revealed: false)
    }

    mutating func checkAndRevealWord(word: String) -> Bool { 
        if let wordFound = words[word] {
            if wordFound.revealed {
                print("Word already revealed: [\(word)]")
                return true
            } else {
                print("Revealing \(word)")
                for tile in wordFound.letterCells {
                    let tileRow = rows[tile.row]
                    rows[tile.row] = tileRow.revealTile(tile: tile)
                }
                words[word] = wordFound.reveal()
                return true
            }
        } else {
            print("Word not found: [\(word)]")
            return false
        }
    }
    
    func boardIsSolved() -> Bool {
        words.values.allSatisfy { w in
            w.revealed
        }
    }
}