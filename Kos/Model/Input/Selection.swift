//
//  SelectedLetter.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 30/04/2023.
//

import Foundation

struct SelectedWord {
    let letters: [SelectedLetter]
    
    static let empty: SelectedWord = SelectedWord(letters: [])
    
    func isLetterSelected(id: Int, inputLetterIndex: Int) -> Bool {
        return letters.contains(where: { s in
            s.letterIndex == inputLetterIndex && s.letterId == id
        })
    }
    
    func selectLetter(id: Int, index: Int) -> SelectedWord {
        if isLetterSelected(id: id, inputLetterIndex: index) {
            return self
        }
        
        let selectedLetter = SelectedLetter(letterId: id, letterIndex: index)
        
        if letters.isEmpty {
            return SelectedWord(letters: [selectedLetter])
        } else {
            let last = letters.last!
            if last.letterId != id {
                return SelectedWord(letters: [selectedLetter])
            }
        }
        
        return self
    }
    
    func unselectLetter(id: Int, index: Int) -> SelectedWord {
        if !isLetterSelected(id: id, inputLetterIndex: index) {
            return self
        }
        
        if letters.isEmpty {
            return self
        } else {
            let last = letters.last!
            if last.letterId == id {
                var l = letters
                l.removeLast()
                return SelectedWord(letters: l)
            }
        }
        
        return self
    }
}

struct SelectedLetter: Hashable {
    let letterId: Int
    let letterIndex: Int
}
