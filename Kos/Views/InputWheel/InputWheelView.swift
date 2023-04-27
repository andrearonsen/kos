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
                    isDragging = true
                    modelData.game.testOneTrue()
                    print("CHANGED (\(e.location)")
                }
                .onEnded { e in
                    isDragging = false
                    modelData.game.testSetAll(selected: false)
                    print("END (\(e.location)")
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
