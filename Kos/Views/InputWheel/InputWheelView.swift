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
    var body: some View {
            ZStack {
                InputWheelBackground()
                InputLettersView(game: game, height: height)
            }.frame(height: height)
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
