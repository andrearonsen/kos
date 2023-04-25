//
//  InputLetterView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct InputLetterView: View {
    var inputLetter: InputLetter
    var selected: Bool = false
    var height: CGFloat
    
    var body: some View {
        let fontSize = height * 0.8
        let circleSize = height
        let text = Text(inputLetter.letter)
            .bold()
            .font(.system(size: fontSize))
        
        if selected == true {
            text
            .foregroundColor(GameColors.foreground)
            .background(
                Circle()
                    .fill(GameColors.defaultGameColor)
                    .frame(width: circleSize, height: circleSize)
            )
        } else {
            text
            .foregroundColor(GameColors.inputWheelNotSelectedForeground)
        }
        
    }
}

struct InputLetterView_Previews: PreviewProvider {
    static var previews: some View {
        InputLetterView(inputLetter: InputLetter(id: 0, letter: "W"), height: 100)
    }
}
