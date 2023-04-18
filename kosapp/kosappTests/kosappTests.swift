//
//  kosappTests.swift
//  kosappTests
//
//  Created by André Fagerlie Aronsen on 15/04/2023.
//

import XCTest
@testable import kosapp

final class kosappTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testSimple() throws {
//        let dictCat = readDictionaryCatalog()
//        print(dictCat.forNumberOfInputLetters(nrInputLetters: 4).countWords())
//        var board = Board(width: 9, height: 6)
//
//        let dir = board.canPlaceWord(row: 0, col: 0, word: "hallo")
//        board.placeWord(row: 0, col: 0, dir: dir, word: "hallo")
//        board.printBoard()
//    }
    
    func testGenerator() throws {
        let dictCat = readDictionaryCatalog()
        let dict = dictCat.forNumberOfInputLetters(nrInputLetters: 4)
        var board = generate_placement(dict: dict, gridWidth: 5, gridHeight: 5, maxWords: 3)
        board.printBoard()
    }

}
