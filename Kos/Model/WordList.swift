//
//  Dictionary.swift
//  
//
//  Created by André Fagerlie Aronsen on 19/04/2023.
//

import Foundation

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
}

public struct WordListCatalog {
    var dict34: WordList
    var dict35: WordList
    var dict36: WordList
    
    public func forNumberOfInputLetters(nrInputLetters: Int) -> WordList {
        switch nrInputLetters {
        case 4: return self.dict34
        case 5: return self.dict35
        case 6: return self.dict36
        default:
            fatalError("Invalid nr of input letters")
        }
    }
}

public func readDictionaryCatalog() -> WordListCatalog {
    let dict34 = readDict(dictFile: "dict34")
    let dict35 = readDict(dictFile: "dict35")
    let dict36 = readDict(dictFile: "dict36")
    return WordListCatalog(dict34: dict34, dict35: dict35, dict36: dict36)
}

func readDict(dictFile: String) -> WordList {
    guard let fileUrl = Bundle.main.url(forResource: dictFile, withExtension: "txt") else {
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

