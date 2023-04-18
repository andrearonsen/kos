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
    
    func testGenerator() throws {
        let dictCat = readDictionaryCatalog()
        let dict = dictCat.forNumberOfInputLetters(nrInputLetters: 4)
        let board = generate_board(dict: dict, gridWidth: 6, gridHeight: 5, maxWords: 4)
        board.printBoard()
    }

}
