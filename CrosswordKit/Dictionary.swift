//
//  dict.swift
//  CrosswordKit
//
//  Created by André Fagerlie Aronsen on 18/04/2023.
//

import Foundation

public struct Dictionary {
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

public struct DictionaryCatalog {
    var dict34: Dictionary
    var dict35: Dictionary
    var dict36: Dictionary
    
    public func forNumberOfInputLetters(nrInputLetters: Int) -> Dictionary {
        switch nrInputLetters {
        case 4: return self.dict34
        case 5: return self.dict35
        case 6: return self.dict36
        default:
            fatalError("Invalid nr of input letters")
        }
    }
}

public func readDictionaryCatalog() -> DictionaryCatalog {
    let dict34 = readDict(dictFile: "dict34")
    let dict35 = readDict(dictFile: "dict35")
    let dict36 = readDict(dictFile: "dict36")
    return DictionaryCatalog(dict34: dict34, dict35: dict35, dict36: dict36)
}

func readDict(dictFile: String) -> Dictionary {
    //let bundle = Bundle(for: DictionaryCatalog.Type)
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
    
    return Dictionary(words: words)
}

