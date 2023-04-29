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
    
    init(cfg: GameConfig, board: TileBoard) {
        self.cfg = cfg
        self.board = board
        self.inputLetters = board.inputLetters()
        self.selectedInputLetters = []
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
        let gameConfig = GameConfig.startConfig()
        
        let startBoard = createBoard(gameConfig: gameConfig)
  
        return Game(cfg: gameConfig, board: startBoard)
    }
    
    func isSolved() -> Bool {
        return board.boardIsSolved()
    }

    mutating func newGame() {
        level += 1
        print("New game: [new level = \(level)]")
        
        cfg = GameConfig.configForLevel(level: level)
        board = createBoard(gameConfig: cfg)
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
        for il in inputLetters {
            il.state.setSelected(sel: false)
        }
        selectedInputLetters = []
    }
    
    mutating func testOneTrue() {
        inputLetters[3].state.setSelected(sel: true)
        inputLetters[1].state.setSelected(sel: true)
    }
    
    mutating func previewRevealAllWords() {
        for wordOnBoard in board.words.keys {
            (board, _) = board.checkAndRevealWord(word: wordOnBoard)
        }
    }
    
    mutating func selectInputLetter(id: Int) {
        let il = inputLetters[id]
        if !il.state.selected {
            print("Selected \(il.id): \(il.letter)")
            il.state.setSelected(sel: true)
            
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
        if il.state.selected {
            il.state.setSelected(sel: false)
            
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

func createBoard(gameConfig: GameConfig) -> TileBoard {
    let cfg = gameConfig.boardConfig
    
    let generateNewBoard = { () -> Board in
        let firstWord = WordLists.catalog.randomFirstWord(nrInputLetters: cfg.nrInputLetters)
        return generate_board(
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
    } while ((currentNrWords < cfg.minWords || currentScore < 32)) //&& nrTries < 30)
    
    print("Final BoardScore: \(currentScore)")
    b.printBoard()

    return b.createTileBoard()
}

