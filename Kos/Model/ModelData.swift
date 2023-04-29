//
//  ModelData.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import Foundation

final class ModelData: ObservableObject { 
    @Published var game = Game.startNewGame()
}

final class CrosswordData: ObservableObject {
    @Published var rows: [TileRow]
    @Published var words: [String: TileBoardWord]
    let letters: [Character]
    let nrCols: Int
    
    init(previewReveal: Bool) {
        let game = Game.startNewGame()
        rows = game.currentBoard.rows
        letters = game.currentBoard.letters
        nrCols = game.currentBoard.nrCols
        words = game.currentBoard.words
        
        if previewReveal {
            previewRevealAllWords()
            printBoard()
        }
    }
    
    func checkAndRevealWord(word: String) -> Bool {
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
    
    func printBoard() {
        var s = ""
        
        for r in rows {
            for c in r.tiles {
                switch c.state {
                case .empty:
                    s += "*"
                case .hidden:
                    s += "$"
                case .revealed:
                    s += c.letter
                }
                s += " "
            }
            s += "\n"
        }
        print(s)
        print()
        print(words)
    }
    
    func previewRevealAllWords() {
        for wordOnBoard in words.keys {
            _ = checkAndRevealWord(word: wordOnBoard)
        }
    }
}
