//
//  Game.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import Foundation
import SwiftUI

struct Game {
    let cfg: GameConfig
    let inputWord: InputWord
    let level: Int
    let board: TileBoard
    let gameColor: Color
    
    static func startNewGame() -> Game {
        print("Starting new game ...")
        return newGame(currentLevel: 0)
    }
    
    static func newGame(currentLevel: Int) -> Game {
        let level = currentLevel + 1
        print("New game on level=[\(level)]")
        
        let gameConfig = GameConfig.configForLevel(level: level)
        let board = createBoard(gameConfig: gameConfig)
        board.printBoard()
        
        return Game(
            cfg: gameConfig,
            inputWord: InputWord.startInput(letters: board.inputLetters()),
            level: level,
            board: board,
            gameColor: GameColors.defaultGameColor
        )
    } 

}
