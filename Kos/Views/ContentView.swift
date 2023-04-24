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
        ZStack {
            Background(image: Image("Pikachu"))
            VStack {
                CrosswordView(game: game)
            }
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
