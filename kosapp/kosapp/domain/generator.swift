//
//  generator.swift
//  kosapp
//
//  Created by André Fagerlie Aronsen on 16/04/2023.
//

import Foundation

func generate_placement(dict: Dictionary, gridWidth: Int, gridHeight: Int, maxWords: Int) -> Board {
    var board = Board(width: gridWidth, height: gridHeight)
    var words = dict.shuffleWords()
    var word = words.popLast()!
    board.placeWord(row: 0, col: 0, dir: .Horizontal, word: word)
    var count = 1
    
    while count < maxWords && !words.isEmpty {
        word = words.popLast()!
        for c in word {
            let letter = String(c)
            for y in 0...gridHeight-1 {
                for x in 0...gridWidth-1 {
                    if board.hasLetter(row: y, col: x, letter: letter) {
                        let placement = board.canPlaceWord(row: y, col: x, word: word)
                        if placement != .NotPossible {
                            board.placeWord(row: y, col: x, dir: placement, word: word)
                            count += 1
                            print(word)
                            continue
                        }
                        
                    }
                }
            }
        }
    }
    
    return board
}
