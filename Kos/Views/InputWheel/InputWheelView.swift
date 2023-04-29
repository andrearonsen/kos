//
//  InputWheelView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct InputWheelView: View {
    @EnvironmentObject var gameData: GameData
    var height: CGFloat
    @State var isDragging: Bool = false
    
    var body: some View {
        GeometryReader { geometry in 
            ZStack {
                InputWheelBackground()
                InputLettersView(height: height)
                // TODO Draw path
            }
            .frame(height: height)
            .gesture(DragGesture()
                .onChanged { e in
                    isDragging = true
                    //print("CHANGED (\(e.location)")
                    for il in gameData.game.inputLetters {
                        if il.boundingBox().contains(e.location) {
                            gameData.game.selectInputLetter(id: il.id)
                            break
                        }
                    }
                }
                .onEnded { e in
                    isDragging = false
                    let success = gameData.game.trySelectedWord()
                    if success {
                        // Confetti -> Correct word
                        if gameData.game.board.boardIsSolved() {
                            print("SOLVED!")
                        }
                        
                    }
                    gameData.game.unselectAllInputLetters()
                    //print("END (\(e.location)")
                    for il in gameData.game.inputLetters {
                        print("\(il.letter): mid=\(il.position), size=\(il.size), box=\(il.boundingBox())")
                    }
                    
                })
        }
    }
    
}

struct InputWheelView_Previews: PreviewProvider {
    static var gameData = GameData()
    static var previews: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
            }.safeAreaInset(edge: .bottom) {
                InputWheelView(height: geometry.size.height / 2)
                    .environmentObject(gameData)
            }
        }
    }
}
