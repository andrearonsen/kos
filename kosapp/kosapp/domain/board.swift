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
        self.matrix = Matrix<String>(rows: height, columns: width, defaultValue: emptyCell)
    }
    
    func lastColIndex() -> Int {
        return self.matrix.columns - 1
    }
    
    func lastRowIndex() -> Int {
        return self.matrix.rows - 1
    }
    
    func hasLetter(row: Int, col: Int, letter: String) -> Bool {
        let cell = self.matrix[row, col]
        return cell == letter.uppercased()
    }
    
    func isEmpty(row: Int, col: Int) -> Bool {
        return self.hasLetter(row: row, col: col, letter: emptyCell)
    }
    
    func isEmptyEast(row: Int, col: Int) -> Bool {
        if col >= self.lastColIndex() {
            return true
        }
        return self.isEmpty(row: row, col: col+1)
    }
    
    func isEmptyWest(row: Int, col: Int) -> Bool {
        if col <= 0 {
            return true
        }
        return self.isEmpty(row: row, col: col-1)
    }
    
    func isEmptyNorth(row: Int, col: Int) -> Bool {
        if row <= 0 {
            return true
        }
        return self.isEmpty(row: row-1, col: col)
    }
    
    func isEmptySouth(row: Int, col: Int) -> Bool {
        if row >= self.lastRowIndex() {
            return true
        }
        return self.isEmpty(row: row+1, col: col)
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
        print("Horizontal: " + word)
        
        if col + word.count > self.matrix.columns {
            return false
        }
        
        for (i, letter) in word.enumerated() {
            let currentCol = col + i
            let empty = self.isEmpty(row: row, col: currentCol)
            let northEmpty = self.isEmptyNorth(row: row, col: currentCol)
            let southEmpty = self.isEmptySouth(row: row, col: currentCol)
            let westEmpty = self.isEmptyWest(row: row, col: currentCol)
            let eastEmpty = self.isEmptyEast(row: row, col: currentCol)
            let hasLetter = self.hasLetter(row: row, col: currentCol, letter: String(letter))
            let hasLetterOrEmpty = hasLetter || empty
            
            if i == 0 {
                // First letter
                let firstLetterOk = hasLetter && westEmpty && eastEmpty
                if !firstLetterOk {
                    return false
                }
            } else {
                // Rest of letters
                let letterOk = hasLetterOrEmpty && northEmpty && southEmpty && eastEmpty
                if !letterOk {
                    return false
                }
            }
        }
        return true
    }
    
    func canPlaceWordVertically(row: Int, col: Int, word: String) -> Bool {
        print("Vertical: " + word)
        
        if row + word.count > self.matrix.rows {
            return false
        }

        for (i, letter) in word.enumerated() {
            let currentRow = row + i
            let empty = self.isEmpty(row: currentRow, col: col)
            let northEmpty = self.isEmptyNorth(row: currentRow, col: col)
            let southEmpty = self.isEmptySouth(row: currentRow, col: col)
            let westEmpty = self.isEmptyWest(row: currentRow, col: col)
            let eastEmpty = self.isEmptyEast(row: currentRow, col: col)
            let hasLetter = self.hasLetter(row: currentRow, col: col, letter: String(letter))
            let hasLetterOrEmpty = hasLetter || empty
            
            if i == 0 {
                // First letter
                let firstLetterOk = hasLetter && northEmpty && southEmpty
                if !firstLetterOk {
                    return false
                }
            } else {
                let letterOk = hasLetterOrEmpty && westEmpty && eastEmpty && southEmpty
                if !letterOk {
                    return false
                }
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
