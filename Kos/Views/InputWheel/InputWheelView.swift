//
//  InputWheelView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct InputWheelView: View {
    static let coordinateSystemName: String = "inputwheel-cs"
    
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
            .coordinateSpace(name: Self.coordinateSystemName)
            .gesture(DragGesture()
                .onChanged { e in
                    isDragging = true
//                    modelData.game.testOneTrue()
                    print("CHANGED (\(e.location)")
                    for il in modelData.game.inputLetters {
                        if il.boundingBox().contains(e.location) {
                            modelData.game.setInputLetterToSelected(id: il.id)
                            break
                        }
                    }
                }
                .onEnded { e in
                    isDragging = false
                    modelData.game.unselectAllInputLetters()
                    print("END (\(e.location)")
                    print(modelData.inputLetterPositions)
                    for il in modelData.game.inputLetters {
                        print("\(il.letter): mid=\(il.position), size=\(il.size), box=\(il.boundingBox())")
                    }
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
