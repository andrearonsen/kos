//
//  WordListTest.swift
//  KosTests
//
//  Created by André Fagerlie Aronsen on 29/04/2023.
//

import XCTest

final class WordListTest: XCTestCase {

    func testRandomFirstWord() throws {
        for i in 3...6 {
            let firstWord = WordLists.catalog.randomFirstWord(nrInputLetters: i)
            XCTAssert(firstWord.count == i)
        }
    }
    
    func testNumberWords() throws {
        for i in 3...6 {
            let wl = WordLists.catalog.wordListForNumberOfInputLetters(nrInputLetters: i)
            for w in wl.words {
                XCTAssert(w.count <= i)
            }
        }
    }
    
    func testShuffleAndFilterOnWord() throws {
        for i in 3...6 {
            let wl = WordLists.catalog.wordListForNumberOfInputLetters(nrInputLetters: i)
            let randomWord = wl.pickRandomWord()
            for w in wl.shuffleAndFilterOnWord(word: randomWord) {
                XCTAssert(w.containsOnlyLettersFrom(word: randomWord))
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            _ = WordListCatalog()
        }
    }

}
