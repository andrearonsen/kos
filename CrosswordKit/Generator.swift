//
//  generator.swift
//  CrosswordKit
//
//  Created by André Fagerlie Aronsen on 18/04/2023.
//

import Foundation

public func hallois() -> String {
    return "hhhh"
}

// https://www.baeldung.com/cs/generate-crossword-puzzle (Algorithm 1)
public func generate_board(dict: Dictionary, gridWidth: Int, gridHeight: Int, maxWords: Int) -> Board {
    var board = Board(width: gridWidth, height: gridHeight)
    var words = dict.shuffleWords()
    var word = words.removeLast()
    board.placeFirstWordRandomDir(word: word)
    var count = 1
    
outer: while count < maxWords && !words.isEmpty {
        word = words.removeLast().uppercased()
        for c in word {
            let letter = String(c)
            for y in 0...gridHeight-1 {
                for x in 0...gridWidth-1 {
                    if board.hasLetter(row: y, col: x, letter: letter) {
                        let placement = board.canPlaceWord(row: y, col: x, word: word)
                        if placement.dir != .NotPossible {
                            board.placeWord(wp: placement)
                            count += 1
                            continue outer
                        }
                        
                    }
                }
            }
        }
    }
    
    return board
}

public func generate_board2(dict: Dictionary, gridWidth: Int, gridHeight: Int, maxWords: Int) -> Board {
    var board = Board(width: gridWidth, height: gridHeight)
    var words = dict.shuffleWords()
    var word = words.removeLast()
    board.placeWord(wp: WordPlacement(word: word, dir: .Horizontal, row: 0, col: 0))
    var count = 1
    
    while count < maxWords && !words.isEmpty {
        word = words.removeLast().uppercased()
        let placements = board.findAllPossibleWordPlacements(word: word)
        var bestScore = 0.0
        var bestBoard = board
        for placement in placements {
            let newBoard = board.placeWordClone(wp: placement)
            let newScore = newBoard.score()
            if newScore > bestScore {
                bestScore = newScore
                bestBoard = newBoard
            }
        }
        if bestScore > 0 {
            board = bestBoard
            count += 1
        }
    }
    
    return board
}

