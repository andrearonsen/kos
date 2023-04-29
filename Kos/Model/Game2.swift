//
//  Game2.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 29/04/2023.
//

import Foundation
import SwiftUI

struct Game2 {
    let cfg: GameConfig
    let inputLetters: [InputLetter]
    let selectedInputLetters: [InputLetter]
    let level: Int
    let board: TileBoard
    let gameColor: Color
    let matchedWordsNotOnBoard: [String]

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
    
    static func newGame2(currentLevel: Int) -> Game2 {
        let level = currentLevel + 1
        print("New game on level=[\(level)]")
        
        let gameConfig = GameConfig.configForLevel(level: level)
        let board = createBoard(gameConfig: gameConfig)
        return Game2(
            cfg: gameConfig,
            inputLetters: board.inputLetters(),
            selectedInputLetters: [],
            level: level,
            board: board,
            gameColor: GameColors.defaultGameColor,
            matchedWordsNotOnBoard: []
        )
    }
    
    static func startNewGame() -> Game2 {
        print("Starting new game ...")
        return newGame2(currentLevel: 0)
    }
    
    func isSolved() -> Bool {
        return board.boardIsSolved()
    }

    func nextGame() -> Game2 {
        return Self.newGame2(currentLevel: level)
    }
    
    func tryWord(w: String) -> (Game2, Bool) {
        print("Trying word: \(w)")
        
        let (newBoard, wordMatch) = board.checkAndRevealWord(word: w)
        if wordMatch {
            return (Game2(
                cfg: cfg,
                inputLetters: newBoard.inputLetters(),
                selectedInputLetters: selectedInputLetters,
                level: level,
                board: newBoard,
                gameColor: GameColors.defaultGameColor,
                matchedWordsNotOnBoard: matchedWordsNotOnBoard
            ), true)
        } else {
            if !matchedWordsNotOnBoard.contains(w) && cfg.wordList.containsWord(w: w) {
                var m = matchedWordsNotOnBoard
                m.append(w)
                
                return (Game2(
                    cfg: cfg,
                    inputLetters: board.inputLetters(),
                    selectedInputLetters: selectedInputLetters,
                    level: level,
                    board: board,
                    gameColor: gameColor,
                    matchedWordsNotOnBoard: m
                ), false)
            }
        }
        return (self, false)
    }
    
    func trySelectedWord() -> (Game2, Bool) {
        let word = selectedWord()
        if word.isEmpty {
            return (self, false)
        }
        return tryWord(w: word)
    }
    
    func selectedWord() -> String {
        return selectedInputLetters.reduce("", { word, il in
            word + il.letter
        })
    }
   
    func unselectAllInputLetters() -> Game2 {
        var unselected: [InputLetter] = []
        for il in inputLetters {
            unselected.append(il.unselect())
        }
        return Game2(
            cfg: cfg,
            inputLetters: unselected,
            selectedInputLetters: [],
            level: level,
            board: board,
            gameColor: gameColor,
            matchedWordsNotOnBoard: matchedWordsNotOnBoard
        )
    }

    func previewRevealAllWords() -> Game2 {
        var b = board
        for wordOnBoard in board.words.keys {
            (b, _) = b.checkAndRevealWord(word: wordOnBoard)
        }
        return Game2(
            cfg: cfg,
            inputLetters: inputLetters,
            selectedInputLetters: selectedInputLetters,
            level: level,
            board: b,
            gameColor: gameColor,
            matchedWordsNotOnBoard: matchedWordsNotOnBoard
        )
    }
    
    func selectInputLetter(id: Int) -> Game2 {
        var ils = inputLetters
        var sel = selectedInputLetters
        let il = ils[id]
        if !il.selected {
            print("Selected \(il.id): \(il.letter)")
            ils[id] = il.select()
            
            if sel.isEmpty {
                sel.append(il)
            } else {
                let last = sel.last!
                if last.id != id {
                    sel.append(il)
                }
            }
            print("Selected word: \(selectedWord())")
        }
        
        return Game2(
            cfg: cfg,
            inputLetters: ils,
            selectedInputLetters: sel,
            level: level,
            board: board,
            gameColor: gameColor,
            matchedWordsNotOnBoard: matchedWordsNotOnBoard
        )
    }
    
    func unselectInputLetter(id: Int) -> Game2 {
        var ils = inputLetters
        var sel = selectedInputLetters
        let il = ils[id]
        if il.selected {
            ils[id] = il.unselect()
            
            if sel.isEmpty {
                return self
            }
            
            let last = sel.last!
            if last.id == id {
                sel.removeLast()
            }
        }
        
        return Game2(
            cfg: cfg,
            inputLetters: ils,
            selectedInputLetters: sel,
            level: level,
            board: board,
            gameColor: gameColor,
            matchedWordsNotOnBoard: matchedWordsNotOnBoard
        )
    }
}
