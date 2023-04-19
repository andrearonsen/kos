//
//  ContentView.swift
//  Kosapp
//
//  Created by André Fagerlie Aronsen on 19/04/2023.
//

import SwiftUI
import CrosswordKit

var dictCat = readDictionaryCatalog()
var dict = dictCat.forNumberOfInputLetters(nrInputLetters: 4)
var puzzle = generate_board2(dict: dict, gridWidth: 5, gridHeight: 4, maxWords: 5)

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
