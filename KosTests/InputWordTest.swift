//
//  InputWordTest.swift
//  KosTests
//
//  Created by André Fagerlie Aronsen on 30/04/2023.
//

import XCTest

final class InputWordTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInputWordSelection() throws {
        let letters = [
            InputLetter(id: 0, letter: "A"),
            InputLetter(id: 1, letter: "B"),
            InputLetter(id: 2, letter: "C")
        ]
        var iw = InputWord.startInput(letters: letters)
        iw = iw.updateLocation(id: 0, position: CGPoint(x: 1, y: 1), size: CGSize(width: 1, height: 1))
        iw = iw.updateLocation(id: 1, position: CGPoint(x: 2, y: 2), size: CGSize(width: 2, height: 2))
        iw = iw.updateLocation(id: 2, position: CGPoint(x: 3, y: 3), size: CGSize(width: 3, height: 3))
        
        XCTAssert(iw.selectedWord() == "")
        iw = iw.selectLetter(id: 0)
        print(iw)
        XCTAssert(iw.selectedWord() == "A")
        iw = iw.selectLetter(id: 2)
        print(iw)
        XCTAssert(iw.selectedWord() == "AC")
        iw = iw.selectLetter(id: 1)
        print(iw)
        XCTAssert(iw.selectedWord() == "ACB")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
