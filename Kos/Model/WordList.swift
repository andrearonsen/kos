//
//  Dictionary.swift
//  
//
//  Created by André Fagerlie Aronsen on 19/04/2023.
//

import Foundation

struct WordLists {
    static let catalog = WordListCatalog()
}

struct WordListCatalog {
    let wl2: WordList
    let wl3: WordList
    let wl4: WordList
    let wl5: WordList
    let wl6: WordList
    
    let wlInput3: WordList
    let wlInput4: WordList
    let wlInput5: WordList
    let wlInput6: WordList
    
    init() {
        print("Init word lists")
        wl2 = readWordList(wordListFile: "wlf2")
        wl3 = readWordList(wordListFile: "wlf3")
        wl4 = readWordList(wordListFile: "wlf4")
        wl5 = readWordList(wordListFile: "wlf5")
        wl6 = readWordList(wordListFile: "wlf6")
        
        wlInput3 = wl2.mergeWith(other: wl3)
        wlInput4 = wl3.mergeWith(other: wl4) // TODO 4 letters -> No 2 letter words?
        wlInput5 = wlInput4.mergeWith(other: wl5)
        wlInput6 = wlInput5.mergeWith(other: wl6)
    }
    
    func wordListForNumberOfInputLetters(nrInputLetters: Int) -> WordList {
        switch nrInputLetters {
        case 3: return self.wlInput3
        case 4: return self.wlInput4
        case 5: return self.wlInput5
        case 6: return self.wlInput6
        default:
            fatalError("Invalid nr of input letters")
        }
    }
    
    func randomFirstWord(nrInputLetters: Int) -> String {
        switch nrInputLetters {
            case 3: return self.wl3.pickRandomWord()
            case 4: return self.wl4.pickRandomWord()
            case 5: return self.wl5.pickRandomWord()
            case 6: return self.wl6.pickRandomWord()
            default:
                fatalError("Invalid nr of input letters")
        }
    }
}

struct WordList {
    let words: [String]
    
    func countWords() -> Int {
        return self.words.count
    }
    
    func shuffleWords() -> [String] {
        return self.words.shuffled()
    }
    
    func pickRandomWord() -> String {
        // Words are ordered by frequency desc
        return self.words[0...200].shuffled().first!
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
    
    func containsWord(w: String) -> Bool {
        for wordInList in words {
            if wordInList == w {
                return true
            }
        }
        return false
    }
}

func readWordList(wordListFile: String) -> WordList {
    print("Reading wordlist: [\(wordListFile)]")
    
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
