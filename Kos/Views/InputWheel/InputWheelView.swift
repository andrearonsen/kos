//
//  InputWheelView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import SwiftUI

struct InputWheelView: View {
    var game: Game
    var height: CGFloat
    
    @State var isDragging: Bool = false
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { e in
                self.isDragging = true
                print("CHANGED (\(e.location)")
            }
            .onEnded { e in
                self.isDragging = false
                print("END (\(e.location)")
            }
    }
    
    var body: some View {
        GeometryReader { geometry in 
            ZStack {
                InputWheelBackground()
                InputLettersView(game: game, height: height)
                
            }
            .frame(height: height)
            .gesture(drag)
        }
    }
}

struct InputWheelView_Previews: PreviewProvider {
    static var game = Game.startNewGame()
    static var previews: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
            }.safeAreaInset(edge: .bottom) {
                InputWheelView(game: game, height: geometry.size.height / 2)
            }
        }
    }
}
