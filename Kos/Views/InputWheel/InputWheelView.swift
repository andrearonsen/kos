//
//  InputWheelView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct InputWheelView: View {
    @EnvironmentObject var modelData: ModelData
    var height: CGFloat
    @State var isDragging: Bool = false
    
    var body: some View {
        GeometryReader { geometry in 
            ZStack {
                InputWheelBackground()
                InputLettersView(height: height)
            }
            .frame(height: height)
            .gesture(DragGesture()
                .onChanged { e in
                    if !isDragging {
                        self.modelData.game.testRevealFirstWord()
                    }
                    isDragging = true
                    //print("CHANGED (\(e.location)")
                    for il in modelData.game.inputLetters {
                        if il.boundingBox().contains(e.location) {
                            modelData.game.selectInputLetter(id: il.id)
                            break
                        }
                    }
                }
                .onEnded { e in
                    isDragging = false
                    if modelData.game.trySelectedWord() {
                        // Confetti
                    }
                    modelData.game.unselectAllInputLetters()
                    //print("END (\(e.location)")
//                    print(modelData.inputLetterPositions)
//                    for il in modelData.game.inputLetters {
//                        print("\(il.letter): mid=\(il.position), size=\(il.size), box=\(il.boundingBox())")
//                    }
                    
                })
        }
    }
    
}

struct InputWheelView_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
            }.safeAreaInset(edge: .bottom) {
                InputWheelView(height: geometry.size.height / 2)
                    .environmentObject(modelData)
            }
        }
    }
}
