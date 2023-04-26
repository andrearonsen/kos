//
//  InputLetter.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 25/04/2023.
//

import Foundation

struct InputLetter: Identifiable {
    let id: Int
    let letter: String
    
    func coordinateSpaceName() -> String {
        return "inputletter-\(id)-\(letter)"
    }
}
