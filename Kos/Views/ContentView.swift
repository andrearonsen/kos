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
                ZStack {
                    Circle()
                        .fill(GameColors.background)
                        .opacity(0.8)
                        .padding()
                    ForEach(game.inputLetters) { letter in
                        let letterText = Text(letter.letter)
                            .foregroundColor(GameColors.inputWheelNotSelected)
                            .bold()
                            .font(.system(size: 130))
                        
                        switch letter.id {
                        case 0:
                            HStack {
                                letterText
                                    .padding([.leading], 40)
                                Spacer()
                            }
                        case 1:
                            VStack {
                                letterText
                                    .padding([.top], 10)
                                Spacer()
                            }
                        case 2:
                            HStack {
                                Spacer()
                                letterText
                                    .padding([.trailing], 40)
                            }
                        case 3:
                            VStack {
                                Spacer()
                                letterText
                            }
                        default:
                            fatalError("More than 4 letters not supported yet")
                        }
                        
                    }
                }
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
