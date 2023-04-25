//
//  InputLettersView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct InputLettersView: View {
    var game: Game
    var height: CGFloat
    
    var body: some View {
        ForEach(game.inputLetters) { letter in
            let letterHeight = height / 3.2
            let inputLetter = InputLetterView(inputLetter: letter, height: letterHeight)
            
            switch letter.id {
            case 0:
                HStack {
                    inputLetter
                        .padding([.leading], 40)
                    Spacer()
                }
            case 1:
                VStack {
                    inputLetter
                        .padding([.top], 10)
                    Spacer()
                }
            case 2:
                HStack {
                    Spacer()
                    inputLetter
                        .padding([.trailing], 40)
                }
            case 3:
                VStack {
                    Spacer()
                    inputLetter
                    .padding([.bottom], 10)
                }
            default:
                fatalError("More than 4 letters not supported yet")
            }
            
        }
    }
}

struct InputLettersView_Previews: PreviewProvider {
    static var game = Game.startNewGame()
    static var previews: some View {
        GeometryReader { geometry in
            let height = geometry.size.height / 2
            VStack {
                Spacer()
            }.safeAreaInset(edge: .bottom) {
                InputLettersView(game: game, height: height)
                    .frame(height: height)
            }
        }
        
    }
}
