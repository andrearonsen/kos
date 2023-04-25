//
//  ContentView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State var game: Game
//    var backgroundImage: Image
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CrosswordView(game: game)
                Spacer()
                InputWheelView(game: game, height: geometry.size.height / 2)
            }
            .background(
                Image("Pikachu")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.3)
            )
        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var game = Game.startNewGame()
    static var previews: some View {
        ContentView(game: game)
            .environmentObject(ModelData())
    }
}
