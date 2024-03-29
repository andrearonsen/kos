//
//  Board.swift
//  
//
//  Created by André Fagerlie Aronsen on 19/04/2023.
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
        self.word = word.uppercased()
        self.dir = dir
        self.row = row
        self.col = col
    }
    
    func toString() -> String {
        return "\(self.word) dir=\(self.dir) row=\(self.row) col=\(self.col)"
    }
}

public struct Board {
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
    
    func nrRows() -> Int {
        return matrix.rows
    }
    
    func nrCols() -> Int {
        return matrix.columns
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
            for x in 0...lastColIndex() {
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
    
    func canPlaceWord(row: Int, col: Int, word: String) -> WordPlacement {
        let w = word.uppercased()
        
        if canPlaceWordHorizontally(row: row, col: col, word: w) {
            return WordPlacement(word: w, dir: .Horizontal, row: row, col: col)
        }
        
        if canPlaceWordVertically(row: row, col: col, word: w) {
            return WordPlacement(word: w, dir: .Vertical, row: row, col: col)
        }
        
        return WordPlacement(word: w, dir: .NotPossible, row: row, col: col)
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
    
    func findAllPossibleWordPlacements(word: String) -> [WordPlacement] {
        let w = word.uppercased()
        var possibilites: [WordPlacement] = []
        
        for c in w {
            let letter = String(c)
            for y in 0...lastRowIndex() {
                for x in 0...lastColIndex() {
                    if hasLetter(row: y, col: x, letter: letter) {
                        if canPlaceWordHorizontally(row: y, col: x, word: w) {
                            let wp = WordPlacement(word: w, dir: .Horizontal, row: y, col: x)
                            possibilites.append(wp)
                        }
                        if canPlaceWordVertically(row: y, col: x, word: w) {
                            let wp = WordPlacement(word: w, dir: .Vertical, row: y, col: x)
                            possibilites.append(wp)
                        }
                    }
                }
            }
        }
        
        return possibilites
    }
    
    mutating func placeWord(wp: WordPlacement) {
        switch wp.dir {
        case .Horizontal:
            for (i, letter) in wp.word.enumerated() {
                let currentCol = wp.col + i
                self.matrix[wp.row, currentCol] = String(letter)
            }
            self.words.append(wp)
        case .Vertical:
            for (i, letter) in wp.word.enumerated() {
                let currentRow = wp.row + i
                self.matrix[currentRow, wp.col] = String(letter)
            }
            self.words.append(wp)
        case .NotPossible:
            return
        }
    }
    
    func clone() -> Board {
        var b = Board(width: nrCols(), height: nrRows())
        for wp in self.words {
            b.placeWord(wp: wp)
        }
        return b
    }
    
    func placeWordClone(wp: WordPlacement) -> Board {
        var b = self.clone()
        b.placeWord(wp: wp)
        return b
    }
    
    mutating func placeFirstWordRandomDir(word: String) {
        assert(self.words.isEmpty)
        
        let dir = randomPlacementDirection(word: word)
        placeWord(wp: WordPlacement(word: word, dir: dir, row: 0, col: 0))
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
    
    public func printBoard() {
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
        printScore()
    }
    
    public func printPuzzle() {
        var s = ""
        
        for r in 0...lastRowIndex() {
            for c in 0...lastColIndex() {
                if isEmpty(row: r, col: c) {
                    s += " "
                } else {
                    s += "\u{2593}"
                }
                s += " "
               
            }
            s += "\n"
        }
        print(s)
        print()
        printWords()
        printScore()
    }
    
    func printWords() {
        for wp in self.words {
            print(wp.toString())
        }
    }
    
    func printScore() {
        print("Score: \(score())")
    }

}
