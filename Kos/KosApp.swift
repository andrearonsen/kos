//
//  KosApp.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import SwiftUI

@main
struct KosApp: App {
    @StateObject private var modelData = ModelData()
    @StateObject private var cwData = CrosswordData(previewReveal: true)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(cwData)
        }
    }
}
