//
//  InputLetter.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import Foundation
import SwiftUI

final class InputLetter: Identifiable {
    let id: Int
    let letter: String
    var position: CGPoint
    var size: CGSize
    var state: InputLetterState
    
    init(id: Int, letter: String) {
        self.id = id
        self.letter = letter
        self.state = InputLetterState()
        self.position = .zero
        self.size = .zero
    }
    
    func boundingBox() -> CGRect {
        return CGRect(origin: CGPoint(x: position.x - size.width / 2, y: position.y - size.height / 2), size: size)
    }
}

struct InputLetterState {
    var selected: Bool = false
    var currentForegroundColor: Color = GameColors.inputWheelNotSelectedForeground
    var currentBackgroundColor: Color = GameColors.background.opacity(0)
    
    mutating func setSelected(sel: Bool) {
        if sel {
            selected = true
            currentForegroundColor = GameColors.foreground
            currentBackgroundColor = GameColors.defaultGameColor
        } else {
            selected = false
            currentForegroundColor = GameColors.inputWheelNotSelectedForeground
            currentBackgroundColor = GameColors.background.opacity(0)
        }
    }
}
