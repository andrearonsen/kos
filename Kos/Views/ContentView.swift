//
//  ContentView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import SwiftUI



struct ContentView: View {
    @EnvironmentObject var gameData: GameData
    @State private var isSolved: Bool = false
    
//    var backgroundImage: Image
   
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    LevelDisplay(level: gameData.level)
                    CrosswordView()
                    Spacer()
                    InputWheelView(height: geometry.size.height / 2, isSolved: $isSolved)
                }
                .background(
                    Image(isSolved ? "Pikachu" : "CatCircle")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .animation(.easeIn(duration: 1), value: isSolved)
                        //.opacity(0.5)
                )
                
                SelectedWordDisplay(selectedWord: gameData.selectedWord())
                ConfettiView(start: isSolved, stop: gameData.stopConfetti, level: gameData.level)
            }
        }
        .gesture(TapGesture()
            .onEnded {
                print("Solved: \(isSolved)")
                print("StopConfetti: \($gameData.stopConfetti)")
                if isSolved {
                    gameData.stopConfetti = true
                    isSolved.toggle()
                    gameData.startNextGame()
                }
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
