//
//  SelectedWord.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 30/04/2023.
//

import Foundation
import SwiftUI

struct InputWord {
    let letters: [InputLetter]
    let selected: SelectedWord
    let matchedWordsNotOnBoard: [String]
    
    static func startInput(letters: [InputLetter]) -> InputWord {
        let countLetters = letters.count
        // TODO Testing hardcoded position
        var ls: [InputLetter] = []
        var i = 0
        for l in letters {
            let (pos, size) = InputWord.hardcodedLetterPosition(countLetters: countLetters, letterIndex: i)
            ls.append(l.locate(position: pos, size: size))
            i += 1
        }
        return InputWord(letters: ls, selected: SelectedWord.empty, matchedWordsNotOnBoard: [])
    }
   
    static func hardcodedLetterPosition(countLetters: Int, letterIndex: Int) -> (CGPoint, CGSize) {
        if letterIndex >= countLetters {
            fatalError("Letter index out of bounds")
        }
        let wheelSize =  UIScreen.main.bounds.size.width
        let letterSize = wheelSize / 3.2
        return (InputWord.calculateInputLetterPosition(
            countLetters: countLetters,
            inputWheelSize: wheelSize, // TODO
            letterSize: letterSize,
            padding: 10,
            letterIndex: letterIndex
        ), CGSize(width: letterSize, height: letterSize))
    }
    
    static func calculateInputLetterPosition(
        countLetters: Int,
        inputWheelSize: CGFloat,
        letterSize: CGFloat,
        padding: CGFloat,
        letterIndex: Int) -> CGPoint {
            
        if countLetters != 4 {
            fatalError("not implemented yet")
        }
        let middle = inputWheelSize / 2
        let offset = letterSize / 2 + padding
        
//        let angle = 360 / countLetters
        switch letterIndex {
        case 0:
            return CGPoint(x: offset, y: middle)
        case 1:
            return CGPoint(x: middle, y: offset)
        case 2:
            return CGPoint(x: inputWheelSize - offset, y: middle)
        case 3:
            return CGPoint(x: middle, y: inputWheelSize - offset)
        default:
            return CGPoint(x: 0, y: 0)
        }
    }
    
    func indexOfLetter(letter: InputLetter) -> Int {
        return indexOfLetterWithId(letterId: letter.id)
    }
    
    func indexOfLetterWithId(letterId: Int) -> Int {
        return letters.firstIndex(where: { $0.id == letterId })!
    }
    
    func selectedWord() -> String {
        var word = ""
        for sel in selected.letters {
            let l = letters[sel.letterIndex]
            word += l.letter
        }
        return word
    }
   
    func unselectAll() -> InputWord {
        var unselected: [InputLetter] = []
        for il in letters {
            unselected.append(il.unselect())
        }
        return InputWord(letters: unselected, selected: SelectedWord.empty, matchedWordsNotOnBoard: matchedWordsNotOnBoard)
    }
    
    func selectLetter(id: Int) -> InputWord {
        var ils = letters
        var sel = selected
        let indexOfLetter = indexOfLetterWithId(letterId: id)
        let il = ils[indexOfLetter]
        if !il.selected {
            print("Selected \(il.id): \(il.letter)")
            ils[indexOfLetter] = il.select()
            sel = sel.selectLetter(id: id, index: indexOfLetter)
            
            let iw = InputWord(letters: ils, selected: sel, matchedWordsNotOnBoard: matchedWordsNotOnBoard)
            print("Selected word: \(iw.selectedWord())")
            return iw
        }
        return self
    }
    
    func unselectLetter(id: Int) -> InputWord {
        var ils = letters
        var sel = selected
        let indexOfLetter = indexOfLetterWithId(letterId: id)
        let il = ils[indexOfLetter]
        if il.selected {
            ils[id] = il.unselect()
            sel = sel.unselectLetter(id: id, index: il.id)
            return InputWord(letters: ils, selected: sel, matchedWordsNotOnBoard: matchedWordsNotOnBoard)
        }
        return self
    }
    
    func updateLocation(id: Int, position: CGPoint, size: CGSize) -> InputWord {
        let i = indexOfLetterWithId(letterId: id)
        var l = letters
        l[i] = l[i].locate(position: position, size: size)
        return InputWord(letters: l, selected: selected, matchedWordsNotOnBoard: matchedWordsNotOnBoard)
    }
    
    func addMatchedWordNotOnBoard(word: String) -> InputWord {
        if !matchedWordsNotOnBoard.contains(word) {
            var m = matchedWordsNotOnBoard
            m.append(word)
            return InputWord(letters: letters, selected: selected, matchedWordsNotOnBoard: m)
        }
        return self
    }
    
    func linesBetweenLetters() -> [CGPoint] {
        var points: [CGPoint] = []
        if selected.letters.isEmpty {
            return points
        }
        
        for l in selected.letters {
            let letter = letters[l.letterIndex]
            points.append(letter.position)
        }
//        points.append(currentPoint)
        return points
    }
}
