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

struct WordPlacement {
    var word: String
    var dir: PlacementDirection
    var row: Int
    var col: Int
    
    init(word: String, dir: PlacementDirection, row: Int, col: Int) {
        self.word = word
        self.dir = dir
        self.row = row
        self.col = col
    }
    
    func toString() -> String {
        return "\(self.word) dir=\(self.dir) row=\(self.row) col=\(self.col)"
    }
}

struct Board {
    var matrix: Matrix<String>
    var words: [WordPlacement]
    
    init(width: Int, height: Int) {
        self.matrix = Matrix<String>(rows: height, columns: width, defaultValue: emptyCell)
        self.words = []
    }
    
    func lastColIndex() -> Int {
        return self.matrix.columns - 1
    }
    
    func lastRowIndex() -> Int {
        return self.matrix.rows - 1
    }
    
    func nrActualRows() -> Int {
        var count = 0
        for row in 0...lastRowIndex() {
            if !rowIsEmpty(row: row){
                count += 1
            }
        }
        return count
    }
    
    func nrActualCols() -> Int {
        var count = 0
        for col in 0...lastColIndex() {
            if !colIsEmpty(col: col){
                count += 1
            }
        }
        return count
    }
    
    func rowIsEmpty(row: Int) -> Bool {
        for col in 0...lastColIndex() {
            if !isEmpty(row: row, col: col) {
                return false
            }
        }
        return true
    }
    
    func colIsEmpty(col: Int) -> Bool {
        for row in 0...lastRowIndex() {
            if !isEmpty(row: row, col: col) {
                return false
            }
        }
        return true
    }
    
    func score() -> Double {
        let rows = nrActualRows()
        let cols = nrActualCols()
        var sizeRatio = Double(rows) / Double(cols)
        if rows > cols {
            sizeRatio = Double(cols) / Double(rows)
        }
        var filled = 0
        var empty = 0
        for y in 0...lastRowIndex() {
//            if rowIsEmpty(row: y) {
//                continue
//            }
            for x in 0...lastColIndex() {
//                if colIsEmpty(col: x) {
//                    continue
//                }
                if isEmpty(row: y, col: x) {
                    empty += 1
                } else {
                    filled += 1
                }
            }
        }
        let filledRatio = Double(filled) / Double(empty)
        return (sizeRatio * 10) + (filledRatio * 20)
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
        let wp = WordPlacement(word: w, dir: dir, row: row, col: col)
        
        switch dir {
        case .Horizontal:
            for (i, letter) in w.enumerated() {
                let currentCol = col + i
                self.matrix[row, currentCol] = String(letter)
            }
            self.words.append(wp)
        case .Vertical:
            for (i, letter) in w.enumerated() {
                let currentRow = row + i
                self.matrix[currentRow, col] = String(letter)
            }
            self.words.append(wp)
        case .NotPossible:
            return
        }
    }
    
    mutating func placeFirstWordRandom(word: String) {
        assert(self.words.isEmpty)
        
        let dir = randomPlacementDirection(word: word)
        
        switch dir {
        case .Horizontal:
            //let row = Int.random(in: 0...self.lastRowIndex())
            let row = 0
            let col = Int.random(in: 0...(self.matrix.columns - word.count))
            self.placeWord(row: row, col: col, dir: dir, word: word)
        case .Vertical:
            let row = Int.random(in: 0...(self.matrix.rows - word.count))
            //let col = Int.random(in: 0...self.lastColIndex())
            let col = 0
            self.placeWord(row: row, col: col, dir: dir, word: word)
        default:
            fatalError("Invalid placement direction")
        }
    }
    
    func randomPlacementDirection(word: String) -> PlacementDirection {
        let wordlen = word.count
        let canPlaceHorizontal = wordlen <= self.matrix.columns
        let canPlaceVertical = wordlen <= self.matrix.rows
        assert(canPlaceHorizontal || canPlaceVertical)
        
        if canPlaceHorizontal && !canPlaceVertical {
            return .Horizontal
        } else if !canPlaceHorizontal && canPlaceVertical {
            return .Vertical
        }
        
        let r = Int.random(in: 0...1000) % 2 == 0
        if r {
            return .Horizontal
        } else {
            return .Vertical
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
        print()
        printWords()
    }
    
    func printWords() {
        for wp in self.words {
            print(wp.toString())
        }
    }

}
