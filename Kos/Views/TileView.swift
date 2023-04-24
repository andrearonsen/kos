//
//  Tile.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import SwiftUI

struct TileView: View {
    var forTile: Tile
    var tileSize: Int
    var filledColor: Color
    
    static let tileEmptyColor = Color.gray.opacity(0.5)
    
    var body: some View {
        let fontSize = CGFloat(Double(tileSize) * 0.75)
        if forTile.isEmpty() {
            TileBackgroundView(size: tileSize, color: Self.tileEmptyColor)
        } else {
            ZStack {
                TileBackgroundView(size: tileSize, color: filledColor)
                Text(forTile.character)
                    .bold()
                    .font(.system(size: fontSize))
                    .foregroundColor(.white)
                    
            }
        }
    }
}

struct TileBackgroundView: View {
    var size: Int
    var color: Color
    
    var body: some View {
        let radius = Double(size) * 0.1
        RoundedRectangle(cornerRadius: radius)
            .fill(color)
            .frame(width: CGFloat(size), height: CGFloat(size))
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(forTile: Tile.A, tileSize: 40, filledColor: Color.purple)
    }
}
