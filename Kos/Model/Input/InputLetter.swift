//
//  InputLetter.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import Foundation
import SwiftUI

struct InputLetter: Identifiable {
    let id: Int
    let letter: String
    let position: CGPoint
    let size: CGSize
    let selected: Bool  
    
    init(id: Int, letter: String) {
        self.init(id: id, letter: letter, position: .zero, size: .zero, selected: false)
    }
    
    init(id: Int, letter: String, position: CGPoint, size: CGSize, selected: Bool) {
        self.id = id
        self.letter = letter
        self.position = position
        self.size = size
        self.selected = selected
    }
    
    func boundingBox() -> CGRect {
        return CGRect(origin: CGPoint(x: position.x - size.width / 2, y: position.y - size.height / 2), size: size)
    }
    
    func select() -> InputLetter {
        return InputLetter(id: id, letter: letter, position: position, size: size, selected: true)
    }
    
    func unselect() -> InputLetter {
        return InputLetter(id: id, letter: letter, position: position, size: size, selected: false)
    }
    
    func locate(position: CGPoint, size: CGSize) -> InputLetter {
        print("Locate [\(id)]: \(position) \(size)")
        return InputLetter(id: id, letter: letter, position: position, size: size, selected: selected)
    }
    
    func foregroundColor() -> Color {
        return GameColors.foregroundForInputLetterSelected(sel: selected)
    }
    
    func backgroundColor() -> Color {
        return GameColors.backgroundForInputLetterSelected(sel: selected)
    }
    
    func fontSize() -> CGFloat {
        return size.height * 0.8
    }
    
    func circleSize() -> CGFloat {
        return size.height
    }
}
