//
//  GameConfig.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 29/04/2023.
//

import Foundation

struct BoardConfig {
    let nrInputLetters: Int
    let gridWidth: Int
    let gridHeight: Int
    let minWords: Int
    let maxWords: Int

    static let startConfig: BoardConfig = BoardConfig(nrInputLetters: 4, gridWidth: 5, gridHeight: 4, minWords: 4, maxWords: 5)
    
    static func configForLevel(level: Int) -> BoardConfig {
        if level >= 0 && level < 10 {
            return BoardConfig(nrInputLetters: 3, gridWidth: 4, gridHeight: 3, minWords: 2, maxWords: 5)
        } else if level >= 10 && level < 20 {
            return BoardConfig(nrInputLetters: 4, gridWidth: 5, gridHeight: 4, minWords: 4, maxWords: 5)
        } else if level >= 20 && level < 30 {
            return BoardConfig(nrInputLetters: 4, gridWidth: 5, gridHeight: 4, minWords: 5, maxWords: 7)
        } else if level >= 30 && level < 40 {
            return BoardConfig(nrInputLetters: 5, gridWidth: 9, gridHeight: 6, minWords: 5, maxWords: 6)
        } else if level >= 40 && level < 50 {
            return BoardConfig(nrInputLetters: 5, gridWidth: 9, gridHeight: 6, minWords: 5, maxWords: 7)
        } else if level >= 50 && level < 60 {
            return BoardConfig(nrInputLetters: 6, gridWidth: 9, gridHeight: 6, minWords: 6, maxWords: 10)
        } else {
            return BoardConfig(nrInputLetters: 6, gridWidth: 9, gridHeight: 6, minWords: 6, maxWords: 15)
        }
    }
}

struct GameConfig {
    let wordList: WordList
    let boardConfig: BoardConfig
    
    static func startConfig() -> GameConfig {
        let bcfg = BoardConfig.startConfig
        let wl = WordLists.catalog.wordListForNumberOfInputLetters(nrInputLetters: bcfg.nrInputLetters)
        return GameConfig(wordList: wl, boardConfig: bcfg)
    }
    
    static func configForLevel(level: Int) -> GameConfig {
        let bcfg = BoardConfig.configForLevel(level: level)
        let wl = WordLists.catalog.wordListForNumberOfInputLetters(nrInputLetters: bcfg.nrInputLetters)
        return GameConfig(wordList: wl, boardConfig: bcfg)
    }
}

