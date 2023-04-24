//
//  Dictionary.swift
//  
//
//  Created by André Fagerlie Aronsen on 19/04/2023.
//

import Foundation

extension String {
    func containsOnlyLettersFrom(word: String) -> Bool {
        let selfStr = self.uppercased()
        let checkStr = word.uppercased()
        for letter in checkStr {
            if !selfStr.contains(letter) {
                return false
            }
        }
        return true
    }
}

public struct WordList {
    var words: [String]
    
    init(words: [String]) {
        self.words = words
    }
    
    func countWords() -> Int {
        return self.words.count
    }
    
    func shuffleWords() -> [String] {
        return self.words.shuffled()
    }
    
    func pickRandomWord() -> String {
        return self.shuffleWords().last!
    }
    
    func shuffleAndFilterOnWord(word: String) -> [String] {
        return self.words.filter { w in
            w.containsOnlyLettersFrom(word: word) && w != word
        }.shuffled()
    }
    
    func mergeWith(other: WordList) -> WordList {
        return WordList(
            words: self.words + other.words
        )
    }
}

struct WordListCatalog {
    let wl3: WordList
    let wl4: WordList
    let wl5: WordList
    let wl6: WordList
    
    let wlInput4: WordList
    let wlInput5: WordList
    let wlInput6: WordList
    
    init(wl3: WordList, wl4: WordList, wl5: WordList, wl6: WordList) {
        self.wl3 = wl3
        self.wl4 = wl4
        self.wl5 = wl5
        self.wl6 = wl6
        self.wlInput4 = wl3.mergeWith(other: wl4)
        self.wlInput5 = wl3.mergeWith(other: wl4).mergeWith(other: wl5)
        self.wlInput6 = wl3.mergeWith(other: wl4).mergeWith(other: wl5).mergeWith(other: wl6)
    }
    
    func wordListForNumberOfInputLetters(nrInputLetters: Int) -> WordList {
        switch nrInputLetters {
        case 4: return self.wlInput4
        case 5: return self.wlInput5
        case 6: return self.wlInput6
        default:
            fatalError("Invalid nr of input letters")
        }
    }
    
    func randomFirstWord(nrInputLetters: Int) -> String {
        switch nrInputLetters {
            case 4: return self.wl4.pickRandomWord()
            case 5: return self.wl5.pickRandomWord()
            case 6: return self.wl6.pickRandomWord()
            default:
                fatalError("Invalid nr of input letters")
        }
    }
}

func readWordListCatalog() -> WordListCatalog {
    let wl3 = readWordList(wordListFile: "wl3")
    let wl4 = readWordList(wordListFile: "wl4")
    let wl5 = readWordList(wordListFile: "wl5")
    let wl6 = readWordList(wordListFile: "wl6")
    return WordListCatalog(wl3: wl3, wl4: wl4, wl5: wl5, wl6: wl6)
}

func readWordList(wordListFile: String) -> WordList {
    guard let fileUrl = Bundle.main.url(forResource: wordListFile, withExtension: "txt") else {
        fatalError("Not able to create URL")
    }
    
    var dict = ""
    do {
        dict = try String(contentsOf: fileUrl)
    } catch {
        assertionFailure("Failed reading from URL: \(fileUrl), Error: " + error.localizedDescription)
    }
    let words = dict
         .split(separator: "\n")
         .map(String.init)
    
    return WordList(words: words)
}

