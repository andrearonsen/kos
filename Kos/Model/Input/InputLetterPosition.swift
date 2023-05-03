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
        
        let padding: CGFloat = InputWheel.padding
        let letterSize = inputWheelSize / letterSizeAdjust(countLetters: countLetters)
        let middle = inputWheelSize / 2
        let offset = letterSize / 2 + padding
        let angleDegrees = CGFloat(360 / CGFloat(countLetters)) * CGFloat(letterIndex)
        let angle = (angleDegrees + 90) * .pi / 180
        let x = middle + (middle - offset) * cos(angle)
        let y = middle - (middle - offset) * sin(angle)
        
        return (
            CGPoint(x: x, y: y),
            CGSize(width: letterSize, height: letterSize)
        )
    }
    
    static private func letterSizeAdjust(countLetters: Int) -> CGFloat {
        switch countLetters {
        case 3: return 3
        case 4: return 3.2
        case 5: return 4.2
        case 6: return 4.5
        default:
            fatalError("incorrect countLetters")
        }
    }
}
