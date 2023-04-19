import XCTest
@testable import CrosswordKit

final class CrosswordKitTests: XCTestCase {
    func testExample() throws {
        let dictCat = readDictionaryCatalog()
        let dict = dictCat.forNumberOfInputLetters(nrInputLetters: 4)
        let board = generate_board2(dict: dict, gridWidth: 5, gridHeight: 4, maxWords: 5)
        board.printBoard()
        board.printPuzzle()
        
        XCTAssertEqual(CrosswordKit().text, "Hello, CrosswordKit!")
    }
}
