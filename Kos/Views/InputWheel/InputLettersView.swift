//
//  InputLettersView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct InputLettersView: View {
    @EnvironmentObject var gameData: GameData
    var height: CGFloat
    
    var body: some View {
        ForEach(gameData.game.inputLetters) { letter in
            let letterHeight = height / 3.2
            InputLetterView(inputLetter: letter, height: letterHeight)
        }
    }
}

struct InputLettersView_Previews: PreviewProvider {
    static var gameData = GameData()
    static var previews: some View {
        GeometryReader { geometry in
            let height = geometry.size.height / 2
            VStack {
                Spacer()
            }.safeAreaInset(edge: .bottom) {
                InputLettersView(height: height)
                    .frame(height: height)
                    .environmentObject(gameData)
            }
        }
        
    }
}
