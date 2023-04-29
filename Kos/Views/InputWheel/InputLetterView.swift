//
//  InputLetterView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct InputLetterView: View {
    @EnvironmentObject var gameData: GameData
    var inputLetter: InputLetter
    var height: CGFloat
    
    var inputLetterIndex: Int {
        gameData.game.inputLetters.firstIndex(where: { $0.id == inputLetter.id })!
    }
   
    var body: some View {
        let fontSize = height * 0.8
        let circleSize = height
//        let il = $gameData.game.inputLetters[inputLetterIndex]
        let selected = gameData.game.inputLetters[inputLetterIndex].selected
        let foreground = GameColors.foregroundForInputLetterSelected(sel: selected)
        let background = GameColors.backgroundForInputLetterSelected(sel: selected)
        
        let letterPosition = gameData.game.calculateInputLetterPosition(
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
                self.gameData.game.inputLetters[inputLetterIndex] =
                inputLetter.locate(position: letterPosition, size: CGSize(width: height, height: height))
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
