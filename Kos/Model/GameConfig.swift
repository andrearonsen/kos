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
}

struct GameConfig {
    let wordList: WordList
    let boardConfig: BoardConfig
    
    static func startConfig() -> GameConfig {
        let bcfg = BoardConfig.startConfig
        let wl = WordLists.catalog.wordListForNumberOfInputLetters(nrInputLetters: bcfg.nrInputLetters)
        return GameConfig(wordList: wl, boardConfig: bcfg)
    }
}
