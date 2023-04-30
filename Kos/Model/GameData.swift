//
//  ModelData.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import Foundation
import SwiftUI

final class GameData: ObservableObject { 
    @Published var inputWord: InputWord
    @Published var level: Int
    @Published var board: TileBoard
    @Published var gameColor: Color
    var cfg: GameConfig
    
    init() {
        let game = Game.startNewGame()
        inputWord = game.inputWord
        level = game.level
        board = game.board
        gameColor = game.gameColor
        cfg = game.cfg
    }
    
    private func updateData(game: Game) {
        inputWord = game.inputWord
        level = game.level
        board = game.board
        gameColor = game.gameColor
        cfg = game.cfg
    }
    
    func startNextGame() {
        let nextGame = Game.newGame(currentLevel: level)
        updateData(game: nextGame)
        objectWillChange.send() // TODO needed?
    }
    
    func inputLetters() -> [InputLetter] {
        return inputWord.letters
    }
    
    func countInputLetters() -> Int {
        return cfg.boardConfig.nrInputLetters
    }
    
    func isSolved() -> Bool {
        return board.boardIsSolved()
    }
    
    func previewRevealAllWords() {
        var b = board
        for wordOnBoard in b.words.keys {
            (b, _) = b.checkAndRevealWord(word: wordOnBoard)
        }
        board = b
        objectWillChange.send()
    }
    
    func selectInputLetter(id: Int) {
        inputWord = inputWord.selectLetter(id: id)
        objectWillChange.send()
    }
    
    func unselectAllLetters() {
        inputWord = inputWord.unselectAll()
        objectWillChange.send()
    }
    
    func trySelectedWord() -> Bool {
        let word = inputWord.selectedWord()
        if word.count >= 3 { // min length
            return tryWord(w: word)
        }
        return false
    }
    
    func tryWord(w: String) -> Bool {
        print("Trying word: \(w)")
        
        let (newBoard, wordMatch) = board.checkAndRevealWord(word: w)
        if wordMatch {
            board = newBoard
            return true
        } else {
            if cfg.wordList.containsWord(w: w) {
                inputWord = inputWord.addMatchedWordNotOnBoard(word: w)
            }
        }
        objectWillChange.send()
        return false
    }
    
    func updateLetterLocation(letterId: Int, position: CGPoint, letterSize: CGFloat) {
        inputWord = inputWord.updateLocation(id: letterId, position: position, size: CGSize(width: letterSize, height: letterSize))
    }
    
}

