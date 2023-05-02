//
//  InputLetterPosition.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 02/05/2023.
//

import Foundation
import SwiftUI

struct InputLetterPosition {
    
    static func calculate(inputWheelSize: CGFloat, countLetters: Int, letterIndex: Int) -> (CGPoint, CGSize) {
        if letterIndex >= countLetters {
            fatalError("Letter index out of bounds")
        }
        
        let padding: CGFloat = 10
        let letterSize = inputWheelSize / letterSizeAdjust(countLetters: countLetters)
        let middle = inputWheelSize / 2
        let offset = letterSize / 2 + padding
        let angleDegrees = CGFloat(360 / CGFloat(countLetters)) * CGFloat(letterIndex)
        let angle = (angleDegrees + angleAdjust(countLetters: countLetters)) * .pi / 180
        let x = middle + (middle - offset) * cos(angle)
        let y = middle - (middle - offset) * sin(angle)
        
        return (
            CGPoint(x: x, y: y),
            CGSize(width: letterSize, height: letterSize)
        )
    }
    
    static private func letterSizeAdjust(countLetters: Int) -> CGFloat {
        switch countLetters {
        case 3: return 2.5
        case 4: return 3.2
        case 5: return 4.2
        case 6: return 4.5
        default:
            fatalError("incorrect countLetters")
        }
    }
    
    static private func angleAdjust(countLetters: Int) -> CGFloat {
        switch countLetters {
        case 3: return 0 // TODO
        case 4: return 0
        case 5: return 18
        case 6: return 30
        default:
            fatalError("incorrect countLetters")
        }
    }
    
//    static func testCorrectValueFor4Letters(inputWheelSize: CGFloat, offset: CGFloat, middle: CGFloat, letterIndex: Int) -> CGPoint {
//        switch letterIndex {
//            case 0:
//                return CGPoint(x: offset, y: middle)
//            case 1:
//                return CGPoint(x: middle, y: offset)
//            case 2:
//                return CGPoint(x: inputWheelSize - offset, y: middle)
//            case 3:
//                return CGPoint(x: middle, y: inputWheelSize - offset)
//            default:
//                return CGPoint(x: 0, y: 0)
//            }
//    }
}
