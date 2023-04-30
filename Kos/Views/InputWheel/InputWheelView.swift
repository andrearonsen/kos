//
//  InputWheelView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct InputWheelView: View {
    @EnvironmentObject var gameData: GameData
    
    let height: CGFloat
    
    @State var isDragging: Bool = false
    @State var currentPoint: CGPoint = .zero
    
    var body: some View {
        GeometryReader { geometry in 
            ZStack {
                InputWheelBackground()
                if isDragging && gameData.inputWord.selected.letters.count > 0 {
                    let points = gameData.inputWord.linesBetweenLetters()
                    SelectedWordLines(currentPoint: currentPoint, points: points)
                }
                ForEach(gameData.inputLetters()) { letter in
                    let letterHeight = height / 3.2
                    InputLetterView(inputLetter: letter, height: letterHeight)
                }
            }
            .frame(height: height)
            .gesture(DragGesture()
                .onChanged { e in
                    isDragging = true
                    currentPoint = e.location
                    //print("CHANGED (\(e.location)")
                    gameData.updateSelectedLetters(currentPoint: e.location)
                    
                }
                .onEnded { e in
                    isDragging = false
                    let success = gameData.trySelectedWord()
                    if success {
                        // Confetti -> Correct word
                        if gameData.isSolved() {
                            print("SOLVED!")
                        }
                        
                    }
                    gameData.unselectAllLetters()
                    //print("END (\(e.location)")
                    for il in gameData.inputLetters() {
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
