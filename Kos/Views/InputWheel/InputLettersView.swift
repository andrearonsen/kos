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
            let inputLetterView =
            InputLetterView(inputLetter: letter, height: letterHeight)
            
            switch letter.id {
            case 0:
                HStack {
                    inputLetterView
                        .padding([.leading], 40)
                    Spacer()
                }
            case 1:
                VStack {
                    inputLetterView
                        .padding([.top], 10)
                    Spacer()
                }
            case 2:
                HStack {
                    Spacer()
                    inputLetterView
                        .padding([.trailing], 40)
                }
            case 3:
                VStack {
                    Spacer()
                    inputLetterView
                        .padding([.bottom], 10)
                }
            default:
                fatalError("More than 4 letters not supported yet")
            }
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
