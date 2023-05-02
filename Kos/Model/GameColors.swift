//
//  GameColors.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct GameColors {
    static let background: Color = Color(red: 245/255, green: 245/255, blue: 245/255)
    static let foreground: Color = .white
    //static let inputWheelNotSelectedForeground: Color = Color(red: 105/255, green: 105/255, blue: 105/255)
    static let inputWheelNotSelectedForeground: Color = .black
    static let inputWheelSelectedForeground: Color = Color(red: 105/255, green: 105/255, blue: 105/255)
    static let defaultGameColor: Color = .purple
    
    static func foregroundForInputLetterSelected(sel: Bool) -> Color {
        return sel ? GameColors.foreground : GameColors.inputWheelNotSelectedForeground
    }
    
    static func backgroundForInputLetterSelected(sel: Bool) -> Color {
        return sel ? GameColors.defaultGameColor : GameColors.background.opacity(0)
    }
}
