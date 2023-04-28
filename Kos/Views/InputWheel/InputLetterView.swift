//
//  InputLetterView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct InputLetterView: View {
    @EnvironmentObject var modelData: ModelData
    var inputLetter: InputLetter
    var height: CGFloat
    
    var inputLetterIndex: Int {
        modelData.game.inputLetters.firstIndex(where: { $0.id == inputLetter.id })!
    }
   
    var body: some View {
        let fontSize = height * 0.8
        let circleSize = height
        let state = $modelData.game.inputLetters[inputLetterIndex].state
        let foreground = state.currentForegroundColor.wrappedValue
        let background = state.currentBackgroundColor.wrappedValue
        
        let letterPosition = modelData.game.calculateInputLetterPosition(
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
                self.modelData.game.inputLetters[inputLetterIndex].position = letterPosition
                self.modelData.game.inputLetters[inputLetterIndex].size = CGSize(width: height, height: height)
            }
        
    }
}

struct InputLetterView_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        InputLetterView(
            inputLetter: InputLetter(id: 0, letter: "W"),
            height: 100)
        .environmentObject(modelData)
    }
}
