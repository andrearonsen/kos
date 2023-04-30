//
//  ContentView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameData: GameData
//    var backgroundImage: Image
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CrosswordView()
                // TODO
                Text(gameData.selectedWord())
                    .bold()
                    .foregroundColor(.blue)
                    .font(.system(size: 20))
                Spacer()
                InputWheelView(height: geometry.size.height / 2)
            }
            .background(
                Image("Pikachu")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.3)
            )
        }.gesture(TapGesture()
            .onEnded {
                //if gameData.game.isSolved() {
                    // TODO Kryssordet funker, men ikke inputwheel!
                    gameData.startNextGame()
                //}
            }
        )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var gameData = GameData()
    static var previews: some View {
        ContentView()
            .environmentObject(gameData)
    }
}
