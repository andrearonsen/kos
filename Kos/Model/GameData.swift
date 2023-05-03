//
//  ModelData.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import Foundation
import SwiftUI

struct AppStorageKeys {
    static let level: String = "level-03052023"
}

final class GameData: ObservableObject {
    var level: Int
    
    @Published var inputWord: InputWord
    @Published var board: TileBoard
    @Published var gameColor: Color
    @Published var stopConfetti: Bool
    @Published var oneWordLeft: Bool
    
    var cfg: GameConfig
    
    init() {
        let currentLevel = UserDefaults.standard.integer(forKey: AppStorageKeys.level)
        let game = Game.newGame(currentLevel: currentLevel)
        level = game.level
        inputWord = game.inputWord
        board = game.board
        gameColor = game.gameColor
        cfg = game.cfg
        stopConfetti = false
        oneWordLeft = false
    }
    
    private func updateData(game: Game) {
        inputWord = game.inputWord
        level = game.level
        board = game.board
        gameColor = game.gameColor
        cfg = game.cfg
        UserDefaults.standard.set(game.level, forKey: AppStorageKeys.level)
    }
    
    func startNextGame() {
        let nextGame = Game.newGame(currentLevel: level)
        updateData(game: nextGame)
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
    }
    
    func selectInputLetter(id: Int) {
        inputWord = inputWord.selectLetter(id: id)
    }
    
    func unselectInputLetter(id: Int) {
        inputWord = inputWord.unselectLetter(id: id)
    }
    
    func unselectAllLetters() {
        inputWord = inputWord.unselectAll()
    }
    
    func selectedWord() -> String {
        return inputWord.selectedWord()
    }
    
    func trySelectedWord() -> Bool {
        let word = selectedWord()
        if word.count >= 2 { // min length
            return tryWord(w: word)
        }
        return false
    }
    
    func tryWord(w: String) -> Bool {
        print("Trying word: \(w)")
        
        let (newBoard, wordMatch) = board.checkAndRevealWord(word: w)
        if wordMatch {
            board = newBoard
            
            print("Word match: stopConfetti=\(stopConfetti)")
            stopConfetti = false
            
            oneWordLeft = newBoard.oneWordLeft()
            if oneWordLeft {
                print("One word left!")
            }
            
            return true
        } else {
            if cfg.wordList.containsWord(w: w) {
                inputWord = inputWord.addMatchedWordNotOnBoard(word: w)
                print("Word not on board but in list: \(w)")
            }
        }
        return false
    }
    
    func updateLetterLocation(letterId: Int, position: CGPoint, letterSize: CGFloat) {
        inputWord = inputWord.updateLocation(id: letterId, position: position, size: CGSize(width: letterSize, height: letterSize))
    }
    
    func updateSelectedLetters(currentPoint: CGPoint) {
        if let currentLetter = inputLetters().first(where: { letter in
            letter.boundingBox().contains(currentPoint)
        }) {
            let currentLetterIndex = inputWord.indexOfLetter(letter: currentLetter)
            let currentLetterId = currentLetter.id
            let currentLetterIsSelected = inputWord.selected.isLetterSelected(id: currentLetterId, inputLetterIndex: currentLetterIndex)
            
            if currentLetterIsSelected {
                if let lastSelected = inputWord.selected.letters.last {
                    if lastSelected.letterId != currentLetterId {
                        unselectInputLetter(id: lastSelected.letterId)
                    }
                }
            } else {
                selectInputLetter(id: currentLetterId)
            }
        }
    }
}
