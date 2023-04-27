//
//  InputLettersView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct InputLettersView: View {
    @EnvironmentObject var modelData: ModelData
    var height: CGFloat
    
    var body: some View {
        ForEach(modelData.game.inputLetters) { letter in
            let letterHeight = height / 3.2
            let letterPosition = modelData.game.calculateInputLetterPosition(
                inputWheelSize: height,
                letterSize: letterHeight,
                padding: 10,
                letterIndex: letter.id
            )

            InputLetterView(inputLetter: letter, height: letterHeight).position(letterPosition)
        }
    }
}

struct InputLettersView_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        GeometryReader { geometry in
            let height = geometry.size.height / 2
            VStack {
                Spacer()
            }.safeAreaInset(edge: .bottom) {
                InputLettersView(height: height)
                    .frame(height: height)
                    .environmentObject(modelData)
            }
        }
        
    }
}
