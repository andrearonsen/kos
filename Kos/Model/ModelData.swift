//
//  ModelData.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 24/04/2023.
//

import Foundation

final class ModelData: ObservableObject {
    static let wordlistCatalog = readWordListCatalog()
    
    @Published var game = Game.startNewGame()
    
}
