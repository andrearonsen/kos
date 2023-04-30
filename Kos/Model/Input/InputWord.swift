//
//  SelectedWord.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 30/04/2023.
//

import Foundation

struct InputWord {
    let letters: [InputLetter]
    let selected: SelectedWord
    let matchedWordsNotOnBoard: [String]
    
    static func startInput(letters: [InputLetter]) -> InputWord {
        return InputWord(letters: letters, selected: SelectedWord.empty, matchedWordsNotOnBoard: [])
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
        for (i, letter) in letters.enumerated() {
            if selected.isLetterSelected(id: letter.id, inputLetterIndex: i) {
                word += letter.letter
            }
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
            let selectedLetter = SelectedLetter(letterId: id, letterIndex: indexOfLetter)
            print("Selected \(il.id): \(il.letter)")
            ils[id] = il.select()
            sel = sel.selectLetter(id: id, index: indexOfLetter)
            print("Selected word: \(selectedWord())")
            return InputWord(letters: ils, selected: sel, matchedWordsNotOnBoard: matchedWordsNotOnBoard)
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
}
