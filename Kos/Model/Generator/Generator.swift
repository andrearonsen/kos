//
//  Generator.swift
//  
//
//  Created by André Fagerlie Aronsen on 19/04/2023.
//

import Foundation

func generate_board(firstWord: String, wl: WordList, gridWidth: Int, gridHeight: Int, maxWords: Int) -> Board {
    let letters = firstWord.shuffleLetters()
    var board = Board(width: gridWidth, height: gridHeight, letters: letters)
    var words = wl.shuffleAndFilterOnWord(word: firstWord)
    
    board.placeFirstWordRandomDir(word: firstWord)
    var count = 1
    
    while count < maxWords && !words.isEmpty {
        let word = words.removeLast()
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

// https://www.baeldung.com/cs/generate-crossword-puzzle (Algorithm 1)
func generate_board_1(firstWord: String, wl: WordList, gridWidth: Int, gridHeight: Int, maxWords: Int) -> Board {
    let letters = firstWord.shuffleLetters()
    var board = Board(width: gridWidth, height: gridHeight, letters: letters)
    var words = wl.shuffleAndFilterOnWord(word: firstWord)
    board.placeFirstWordRandomDir(word: firstWord)
    var count = 1
    
outer: while count < maxWords && !words.isEmpty {
        let word = words.removeLast().uppercased()
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



