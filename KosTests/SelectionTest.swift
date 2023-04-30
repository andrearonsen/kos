//
//  SelectionTest.swift
//  KosTests
//
//  Created by André Fagerlie Aronsen on 30/04/2023.
//

import XCTest

final class SelectionTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsLetterSelected() throws {
        var s = SelectedWord(letters: [])
        XCTAssert(!s.isLetterSelected(id: 0, inputLetterIndex: 0))
       
        s = s.selectLetter(id: 0, index: 0)
        XCTAssert(s.isLetterSelected(id: 0, inputLetterIndex: 0))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
