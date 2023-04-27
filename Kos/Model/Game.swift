//
//  Game.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import Foundation
import SwiftUI

struct BoardConfig {
    let nrInputLetters: Int
    let gridWidth: Int
    let gridHeight: Int
    let minWords: Int
    let maxWords: Int

    static let startConfig: BoardConfig = BoardConfig(nrInputLetters: 4, gridWidth: 5, gridHeight: 4, minWords: 4, maxWords: 5)
}


struct GameConfig {
    let wordList: WordList
    let boardConfig: BoardConfig
    
    static func startConfig() -> GameConfig {
        let bcfg = BoardConfig.startConfig
        let wl = ModelData.wordlistCatalog.wordListForNumberOfInputLetters(nrInputLetters: bcfg.nrInputLetters)
        return GameConfig(wordList: wl, boardConfig: bcfg)
    }
}

struct Game {
    let currentGameConfig: GameConfig
    var inputLetters: [InputLetter]
    var selectedInputLetters: [InputLetter]
    var level: Int = 0
    var currentBoard: TileBoard
    var currentColor: Color = GameColors.defaultGameColor
    var matchedWordsNotOnBoard: [String] = []
    
    init(currentGameConfig: GameConfig, currentBoard: TileBoard) {
        self.currentGameConfig = currentGameConfig
        self.currentBoard = currentBoard
        
        var il: [InputLetter] = []
        for (i, letter) in currentBoard.letters.enumerated() {
            il.append(InputLetter(id: i, letter: String(letter)))
        }
        self.inputLetters = il
        self.selectedInputLetters = []
    }
    
    func calculateInputLetterPosition(
        inputWheelSize: CGFloat,
        letterSize: CGFloat,
        padding: CGFloat,
        letterIndex: Int) -> CGPoint {
        let countLetters = currentBoard.letters.count
        if countLetters != 4 {
            fatalError("not implemented yet")
        }
        let middle = inputWheelSize / 2
        let offset = letterSize / 2 + padding
        
//        let angle = 360 / countLetters
        switch letterIndex {
        case 0:
            return CGPoint(x: offset, y: middle)
        case 1:
            return CGPoint(x: middle, y: offset)
        case 2:
            return CGPoint(x: inputWheelSize - offset, y: middle)
        case 3:
            return CGPoint(x: middle, y: inputWheelSize - offset)
        default:
            return CGPoint(x: 0, y: 0)
        }  
    }
    
    static func startNewGame() -> Game {
        print("Starting new game ...")
        let gameConfig = GameConfig.startConfig()
        
        let startBoard = createBoard(gameConfig: gameConfig)
        var game = Game(currentGameConfig: gameConfig, currentBoard: startBoard)
        
        // Test reveal first word:
        let firstWord = game.currentBoard.words[0].word
        if game.currentBoard.checkAndRevealWord(word: firstWord) {
            print("First word revealed: \(firstWord)")
        }
        
        return game
    }
    
    mutating func tryWord(w: String) -> Bool {
       let wordMatch = currentBoard.checkAndRevealWord(word: w)
        if wordMatch {
            return true
        } else {
            if !matchedWordsNotOnBoard.contains(w) && currentGameConfig.wordList.containsWord(w: w) {
                matchedWordsNotOnBoard.append(w)
            }
        }
        return false
    }
   
    mutating func testSetAll(selected: Bool) {
        for il in inputLetters {
            il.state.setSelected(sel: selected)
        }
    }
    
    mutating func testOneTrue() {
        inputLetters[3].state.setSelected(sel: true)
        inputLetters[1].state.setSelected(sel: true)
    }
}


func createBoard(gameConfig: GameConfig) -> TileBoard {
    let cfg = gameConfig.boardConfig
    
    let generateNewBoard = { () -> Board in
        let firstWord = ModelData.wordlistCatalog.randomFirstWord(nrInputLetters: cfg.nrInputLetters)
        return generate_board2(
            firstWord: firstWord,
            wl: gameConfig.wordList,
            gridWidth: cfg.gridWidth,
            gridHeight: cfg.gridHeight,
            maxWords: cfg.maxWords)
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
        if (newScore > currentScore) && newCountWords >= cfg.minWords {
            b = newBoard
            currentScore = newScore
            currentNrWords = newCountWords
            print("New Score: \(currentScore)")
        }
    } while ((currentNrWords < cfg.minWords || currentScore < 30)) //&& nrTries < 30)
    
    print("Final BoardScore: \(currentScore)")

    return b.createTileBoard()
}

