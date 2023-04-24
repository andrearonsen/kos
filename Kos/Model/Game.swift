//
//  Game.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import Foundation
import SwiftUI

struct Game {
    var level: Int
    var currentBoard: TileBoard
    var currentColor: Color
    
    static func startNewGame() -> Game {
        print("Starting new game ...")
        var startBoard = createBoard(nrInputLetters: 4, gridWidth: 5, gridHeight: 4, minWords: 4, maxWords: 5)
        return Game(level: 0, currentBoard: startBoard, currentColor: Color.purple)
    }
    
//    func nextBoard() -> Board {
//        // TODO Based on level?
//        let nrInputLetters = 4
//        let gridWidth = 5
//        let gridHeight = 4
//        let minWords = 3
//        let maxWords = 5
//
//        return newBoard(nrInputLetters: nrInputLetters, gridWidth: gridWidth, gridHeight: gridHeight, minWords: minWords, maxWords: maxWords)
//    }
}



func createBoard(nrInputLetters: Int, gridWidth: Int, gridHeight: Int, minWords: Int, maxWords: Int) -> TileBoard {
    let wl = ModelData.wordlistCatalog.wordListForNumberOfInputLetters(nrInputLetters: nrInputLetters)
    let generateNewBoard = { () -> Board in
        let firstWord = ModelData.wordlistCatalog.randomFirstWord(nrInputLetters: nrInputLetters)
        return generate_board2(firstWord: firstWord, wl: wl, gridWidth: gridWidth, gridHeight: gridHeight, maxWords: maxWords)
    }
    
    var nrTries = 0
    var b: Board = generateNewBoard()
    var currentScore: Double = b.score()
    var currentNrWords: Int = b.countWords()
    repeat {
        nrTries += 1
        let newBoard = generateNewBoard()
        let newScore = newBoard.score()
        let newCountWords = newBoard.countWords()
        if (newScore > currentScore) && newCountWords >= minWords {
            b = newBoard
            currentScore = newScore
            currentNrWords = newCountWords
            print("New Score: \(currentScore)")
        }
    } while ((currentNrWords < minWords || currentScore < 30)) //&& nrTries < 30)
    
    print("Final BoardScore: \(currentScore)")
    
    var tileBoard = b.createTileBoard()
    
    // Test reveal first word:
    let firstWord = tileBoard.words[0].word
    if tileBoard.checkAndRevealWord(word: firstWord) {
        print("First word revealed: \(firstWord)")
    }
    
    return tileBoard
}
