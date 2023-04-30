//
//  InputLetterView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct InputLetterView: View {
    @EnvironmentObject var gameData: GameData
    
    let inputLetter: InputLetter
    let height: CGFloat
    
    var inputLetterIndex: Int {
        gameData.inputWord.indexOfLetterWithId(letterId: inputLetter.id)
    }
   
    var body: some View {
        let fontSize = height * 0.8
        let circleSize = height
        let selected = inputLetter.selected
        let foreground = GameColors.foregroundForInputLetterSelected(sel: selected)
        let background = GameColors.backgroundForInputLetterSelected(sel: selected)
        
        let letterPosition = InputWord.calculateInputLetterPosition(
            countLetters: gameData.countInputLetters(),
            inputWheelSize: UIScreen.main.bounds.size.width, // TODO
            letterSize: height,
            padding: 10,
            letterIndex: inputLetterIndex
        )
        
        Text(inputLetter.letter)
            .bold()
            .font(.system(size: fontSize))
            .foregroundColor(foreground)
            .background(
                Circle()
                    .fill(background)
                    .frame(width: circleSize, height: circleSize)
            )
            .position(letterPosition)
            .onAppear {
                print("InputLetter Render: \(inputLetterIndex) \(inputLetter.letter)")
                gameData.updateLetterLocation(letterId: inputLetter.id, position: letterPosition, letterSize: height)
            }
        
    }
}

struct InputLetterView_Previews: PreviewProvider {
    static var gameData = GameData()
    static var previews: some View {
        InputLetterView(
            inputLetter: InputLetter(id: 0, letter: "W"),
            height: 100)
        .environmentObject(gameData)
    }
}
