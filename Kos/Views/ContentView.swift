//
//  ContentView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
//    var backgroundImage: Image
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CrosswordView()
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
        }
//        .onAppear {
//            self.modelData.game.testRevealFirstWord()
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        ContentView()
            .environmentObject(modelData)
    }
}
