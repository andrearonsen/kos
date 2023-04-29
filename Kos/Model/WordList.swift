//
//  Dictionary.swift
//  
//
//  Created by André Fagerlie Aronsen on 19/04/2023.
//

import Foundation

extension String {
    
    func characterFrequencies() -> [Character:Int] {
        var freq: [Character:Int] = [:]
        for letter in self {
            if let v = freq[letter] {
                freq[letter] = v + 1
            } else {
                freq[letter] = 1
            }
        }
        return freq
    }

    func containsOnlyLettersFrom(word: String) -> Bool {
        let selfStr = self.uppercased()
        let checkStr = word.uppercased()
        
        // If this string contains characters other than in word => false
//        for letter in selfStr {
//            if !checkStr.contains(letter) {
//                return false
//            }
//        }
        
        // If this string contains a higher frequency of some of the letters than word -> false
        let selfFreq = selfStr.characterFrequencies()
        let checkFreq = checkStr.characterFrequencies()
        
        for (letter, sf) in selfFreq {
            if let cf = checkFreq[letter] {
                if sf > cf {
                    // Letter from self has higher frequency than check
                    return false
                }
            } else {
                // Letter from self does not exist in check
                return false
            }
        }
        
//        for (letter, cf) in checkFreq {
//            if let sf = selfFreq[letter] {
//                if sf > cf {
//                    return false
//                }
//            }
//        }
        
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
        return self.words[0...200].shuffled().first!
//        return self.shuffleWords().last!
    }
    
    func shuffleAndFilterOnWord(word: String) -> [String] {
        return self.words.filter { w in
            w.containsOnlyLettersFrom(word: word) && w != word
            // TODO Add extra condition: Frequency of each character max first word
            // First word: NESE -> ESS and NESS illegal!
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
    
    init(wl2: WordList, wl3: WordList, wl4: WordList, wl5: WordList, wl6: WordList) {
        self.wl2 = wl2
        self.wl3 = wl3
        self.wl4 = wl4
        self.wl5 = wl5
        self.wl6 = wl6
        self.wlInput3 = wl2.mergeWith(other: wl3)
        self.wlInput4 = self.wlInput3.mergeWith(other: wl4)
        self.wlInput5 = self.wlInput4.mergeWith(other: wl5)
        self.wlInput6 = self.wlInput5.mergeWith(other: wl6)
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

func readWordListCatalog() -> WordListCatalog {
    let wl2 = readWordList(wordListFile: "wlf2")
    let wl3 = readWordList(wordListFile: "wlf3")
    let wl4 = readWordList(wordListFile: "wlf4")
    let wl5 = readWordList(wordListFile: "wlf5")
    let wl6 = readWordList(wordListFile: "wlf6")
    return WordListCatalog(wl2: wl2, wl3: wl3, wl4: wl4, wl5: wl5, wl6: wl6)
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

final class WordLists {
    static let catalog = readWordListCatalog()
}
