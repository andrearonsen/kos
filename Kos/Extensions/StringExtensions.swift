//
//  StringExtensions.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 29/04/2023.
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
       
        return true
    }
    
}
