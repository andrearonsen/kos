//
//  Game.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import Foundation
import SwiftUI

struct Game {
    var cfg: GameConfig
    var inputLetters: [InputLetter]
    var selectedInputLetters: [InputLetter]
    var level: Int = 0
    var board: TileBoard
    var gameColor: Color = GameColors.defaultGameColor
    var matchedWordsNotOnBoard: [String] = []
    
    init(cfg: GameConfig, board: TileBoard, level: Int) {
        self.cfg = cfg
        self.board = board
        self.inputLetters = board.inputLetters()
        self.selectedInputLetters = []
        self.level = level
    }
    
//    init(currentGameConfig: GameConfig, currentBoard: TileBoard, matchedWordsNotOnBoard: [String]) {
//        self.init(currentGameConfig: currentGameConfig, currentBoard: currentBoard)
//        self.matchedWordsNotOnBoard = matchedWordsNotOnBoard
//    }
    
    func calculateInputLetterPosition(
        inputWheelSize: CGFloat,
        letterSize: CGFloat,
        padding: CGFloat,
        letterIndex: Int) -> CGPoint {
        let countLetters = board.letters.count
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
//        let gameConfig = GameConfig.startConfig()
//        let startBoard = createBoard(gameConfig: gameConfig)
//        return Game(cfg: gameConfig, board: startBoard, level: 0)
        return nextGame(currentLevel: 0)
    }
    
    func isSolved() -> Bool {
        return board.boardIsSolved()
    }

    static func nextGame(currentLevel: Int) -> Game {
        let level = currentLevel + 1
        print("New game on level=[\(level)]")
        
        let gameConfig = GameConfig.configForLevel(level: level)
        let board = createBoard(gameConfig: gameConfig)
        return Game(cfg: gameConfig, board: board, level: level)
    }
    
//    func tryWord2(w: String) -> (Game, Bool) {
//        print("Trying word: \(w)")
//        let (newBoard, wordMatch) = board.checkAndRevealWord(word: w)
//        if wordMatch {
//            return (Game(currentGameConfig: cfg, currentBoard: newBoard), true)
//        } else {
//            if !matchedWordsNotOnBoard.contains(w) && cfg.wordList.containsWord(w: w) {
//                var m = matchedWordsNotOnBoard
//                m.append(w)
//                return (Game(currentGameConfig: cfg, currentBoard: board, matchedWordsNotOnBoard: m), false)
//            }
//        }
//        return (self, false)
//    }
    
//    func trySelectedWord2() -> (Game, Bool) {
//        let word = selectedWord()
//        if word.isEmpty {
//            return (self, false)
//        }
//        return tryWord2(w: word)
//    }
    
    mutating func tryWord(w: String) -> Bool {
        print("Trying word: \(w)")
        let (newBoard, wordMatch) = board.checkAndRevealWord(word: w)
        if wordMatch {
            board = newBoard
            return true
        } else {
            if !matchedWordsNotOnBoard.contains(w) && cfg.wordList.containsWord(w: w) {
                matchedWordsNotOnBoard.append(w)
            }
        }
        return false
    }
    
    mutating func trySelectedWord() -> Bool {
        let word = selectedWord()
        if word.isEmpty {
            return false
        }
        return tryWord(w: word)
    }
    
    func selectedWord() -> String {
        return selectedInputLetters.reduce("", { word, il in
            word + il.letter
        })
    }
   
    mutating func unselectAllInputLetters() {
        var unselected: [InputLetter] = []
        for il in inputLetters {
            unselected.append(il.unselect())
        }
        selectedInputLetters = []
        inputLetters = unselected
    }
    
//    mutating func testOneTrue() {
//        inputLetters[3].state.setSelected(sel: true)
//        inputLetters[1].state.setSelected(sel: true)
//    }
    
    mutating func previewRevealAllWords() {
        for wordOnBoard in board.words.keys {
            (board, _) = board.checkAndRevealWord(word: wordOnBoard)
        }
    }
    
    mutating func selectInputLetter(id: Int) {
        let il = inputLetters[id]
        if !il.selected {
            print("Selected \(il.id): \(il.letter)")
            inputLetters[id] = il.select()
            
            if selectedInputLetters.isEmpty {
                selectedInputLetters.append(il)
            } else {
                let last = selectedInputLetters.last!
                if last.id != id {
                    selectedInputLetters.append(il)
                }
            }
            print("Selected word: \(selectedWord())")
        }
    }
    
    mutating func unselectInputLetter(id: Int) {
        let il = inputLetters[id]
        if il.selected {
            inputLetters[id] = il.unselect()
            
            if selectedInputLetters.isEmpty {
                return
            }
            
            let last = selectedInputLetters.last!
            if last.id == id {
                selectedInputLetters.removeLast()
            }
        }
    }
}
