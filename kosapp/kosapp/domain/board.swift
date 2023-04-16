//
//  board.swift
//  kosapp
//
//  Created by André Fagerlie Aronsen on 16/04/2023.
//

import Foundation

var emptyCell: String = "*"

enum PlacementDirection {
    case Horizontal
    case Vertical
    case NotPossible
}

struct Board {
    var matrix: Matrix<String>
    
    init(width: Int, height: Int) {
        self.matrix = Matrix<String>(rows: width, columns: height, defaultValue: emptyCell)
    }
    
    func hasLetter(row: Int, col: Int, letter: String) -> Bool {
        let cell = self.matrix[row, col]
        return cell == letter
    }
    
    func isEmpty(row: Int, col: Int) -> Bool {
        return self.hasLetter(row: row, col: col, letter: emptyCell)
    }
    
    func canPlaceWord(row: Int, col: Int, word: String) -> PlacementDirection {
        let w = word.uppercased()
        
        if canPlaceWordHorizontally(row: row, col: col, word: w) {
            return PlacementDirection.Horizontal
        }
        
        if canPlaceWordVertically(row: row, col: col, word: w) {
            return PlacementDirection.Vertical
        }
        
        return PlacementDirection.NotPossible
    }
    
    func canPlaceWordHorizontally(row: Int, col: Int, word: String) -> Bool {
        if col + word.count > self.matrix.columns {
            return false
        }
        
        for (i, letter) in word.enumerated() {
            let currentCol = col + i
            let empty = self.isEmpty(row: row, col: currentCol)
            let hasLetter = self.hasLetter(row: row, col: currentCol, letter: String(letter))
            if !empty && !hasLetter {
                return false
            }
        }
        return true
    }
    
    func canPlaceWordVertically(row: Int, col: Int, word: String) -> Bool {
        if row + word.count > self.matrix.rows {
            return false
        }
        
        for (i, letter) in word.enumerated() {
            let currentRow = row + i
            let empty = self.isEmpty(row: currentRow, col: col)
            let hasLetter = self.hasLetter(row: currentRow, col: col, letter: String(letter))
            if !empty && !hasLetter {
                return false
            }
        }
        return true
    }
    
    mutating func placeWord(row: Int, col: Int, dir: PlacementDirection, word: String) {
        let w = word.uppercased()
        
        switch dir {
        case .Horizontal:
            for (i, letter) in w.enumerated() {
                let currentCol = col + i
                self.matrix[row, currentCol] = String(letter)
            }
        case .Vertical:
            for (i, letter) in w.enumerated() {
                let currentRow = row + i
                self.matrix[currentRow, col] = String(letter)
            }
        case .NotPossible:
            return
        }
    }
    
    func printBoard() {
        var s = ""
        
        for r in 0...self.matrix.rows-1 {
            for c in 0...self.matrix.columns-1 {
                let cell = self.matrix[r, c]
                s += cell
                s += " "
            }
            s += "\n"
        }
        print(s)
    }
}
