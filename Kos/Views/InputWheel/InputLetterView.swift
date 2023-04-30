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
 
    var body: some View {
        let circleSize = inputLetter.circleSize()

        Text(inputLetter.letter)
            .bold()
            .font(.system(size: inputLetter.fontSize()))
            .foregroundColor(inputLetter.foregroundColor())
            .background(
                Circle()
                    .fill(inputLetter.backgroundColor())
                    .frame(width: circleSize, height: circleSize)
            )
            .position(inputLetter.position)
        
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
