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
        let startBoard = newBoard(nrInputLetters: 4, gridWidth: 5, gridHeight: 4, maxWords: 5)
        return Game(level: 0, currentBoard: startBoard, currentColor: Color.purple)
    }
    
    func nextBoard() -> Board {
        // TODO Based on level?
        let nrInputLetters = 4
        let gridWidth = 5
        let gridHeight = 4
        let maxWords = 5
        
        return newBoard(nrInputLetters: nrInputLetters, gridWidth: gridWidth, gridHeight: gridHeight, maxWords: maxWords)
    }
}

func newBoard(nrInputLetters: Int, gridWidth: Int, gridHeight: Int, maxWords: Int) -> Board {
    let firstWord = ModelData.wordlistCatalog.randomFirstWord(nrInputLetters: nrInputLetters)
    let wl = ModelData.wordlistCatalog.wordListForNumberOfInputLetters(nrInputLetters: nrInputLetters)
    return generate_board2(firstWord: firstWord, wl: wl, gridWidth: gridWidth, gridHeight: gridHeight, maxWords: maxWords)
}
