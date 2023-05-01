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
                    Text("Level: \(gameData.level)")
                        .bold()
                        .foregroundColor(.purple)
                        .font(.system(size: 20))
                    
                    CrosswordView()
                    // TODO word view
                    Text(gameData.selectedWord())
                        .bold()
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                    Spacer()
                    InputWheelView(height: geometry.size.height / 2, isSolved: $isSolved)
                }
                .background(
                    Image("Pikachu")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .opacity(0.3)
                )
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
        .gesture(LongPressGesture()
            .onEnded { _ in
                //stopConfetti.toggle()
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
