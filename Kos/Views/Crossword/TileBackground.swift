//
//  TileBackground.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 29/04/2023.
//

import SwiftUI

struct TileBackground: View {
    var size: Int
    var color: Color
    
    var body: some View {
        let radius = Double(size) * 0.1
        RoundedRectangle(cornerRadius: radius)
            .fill(color)
            .frame(width: CGFloat(size), height: CGFloat(size))
            .shadow(radius: 1)
    }
}


struct TileBackground_Previews: PreviewProvider {
    static var previews: some View {
        TileBackground(size: 200, color: Color.orange)
    }
}
