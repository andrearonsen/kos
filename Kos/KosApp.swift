//
//  KosApp.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import SwiftUI

@main
struct KosApp: App {
    @StateObject private var gameData = GameData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameData)
        }
    }
}
