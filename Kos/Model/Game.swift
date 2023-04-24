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
    var currentBoard: Board
    var currentColor: Color
    
    static func startNewGame() -> Game {
        let startBoard = newBoard(nrInputLetters: 4, gridWidth: 5, gridHeight: 4, minWords: 3, maxWords: 5)
        return Game(level: 0, currentBoard: startBoard, currentColor: Color.purple)
    }
    
    func nextBoard() -> Board {
        // TODO Based on level?
        let nrInputLetters = 4
        let gridWidth = 5
        let gridHeight = 4
        let minWords = 3
        let maxWords = 5
        
        return newBoard(nrInputLetters: nrInputLetters, gridWidth: gridWidth, gridHeight: gridHeight, minWords: minWords, maxWords: maxWords)
    }
}



func newBoard(nrInputLetters: Int, gridWidth: Int, gridHeight: Int, minWords: Int, maxWords: Int) -> Board {
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
        if (newScore > currentScore || currentNrWords < minWords) && newCountWords >= minWords {
            b = newBoard
            currentScore = newScore
            currentNrWords = newCountWords
        }
    } while ((currentNrWords < minWords || currentScore < 30) && nrTries < 3)
    
    return b
}
