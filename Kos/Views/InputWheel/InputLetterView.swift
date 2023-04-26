//
//  InputLetterView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct InputLetterView: View {
    let inputLetter: InputLetter
    
    @State var selected: Bool = false
    @State var currentForegroundColor: Color = GameColors.inputWheelNotSelectedForeground
    @State var currentBackgroundColor: Color = GameColors.background.opacity(0)
    
    var height: CGFloat
   
    var body: some View {
        let fontSize = height * 0.8
        let circleSize = height
        
        Text(inputLetter.letter)
            .bold()
            .font(.system(size: fontSize))
            .foregroundColor(currentForegroundColor)
            .background(
                Circle()
                    .fill(currentBackgroundColor)
                    .frame(width: circleSize, height: circleSize)
            )
            .gesture(DragGesture()
                .onChanged { value in
                    selected = true
                    currentForegroundColor = GameColors.foreground
                    currentBackgroundColor = GameColors.defaultGameColor
                }
                .onEnded { value in
                    selected = false
                    currentForegroundColor = GameColors.inputWheelNotSelectedForeground
                    currentBackgroundColor = GameColors.background.opacity(0)
                }
            )
    }
}

struct InputLetterView_Previews: PreviewProvider {
    static var previews: some View {
        InputLetterView(inputLetter: InputLetter(id: 0, letter: "W"), height: 100)
    }
}
