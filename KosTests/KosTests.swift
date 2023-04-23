//
//  KosTests.swift
//  KosTests
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import XCTest
@testable import Kos

final class KosTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let dictCat = Kos.readDictionaryCatalog()
        let dict = dictCat.forNumberOfInputLetters(nrInputLetters: 4)
        let board = generate_board2(dict: dict, gridWidth: 5, gridHeight: 4, maxWords: 5)
        board.printBoard()
        board.printPuzzle()
        
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
