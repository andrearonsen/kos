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
                    CrosswordView()
                    // TODO
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
                
                ForEach(gameData.confettis) { cf in
                    Text(cf.text)
                       // .position(isSolved ? CGPoint(x: 0, y: geometry.size.height + 20) : CGPoint(x: 0, y: 0))
                        .opacity(isSolved ? 1.0 : 0.0)
                        .offset(x: isSolved ? cf.posX : 0)
                        .animation(.easeIn(duration: 10), value: isSolved)
                }
            }
        }
        .gesture(TapGesture()
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
