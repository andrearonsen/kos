//
//  Tile.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import SwiftUI

struct TileView: View {
    let tileCell: TileCell
    let tileSize: Int
    let filledColor: Color
    
    static let tileHiddenColor = Color.gray.opacity(0.5)
    
    var body: some View {
        switch tileCell.tile.state {
            case .empty:
                AirTileView(size: tileSize)
            case .hidden:
                TileBackgroundView(size: tileSize, color: Self.tileHiddenColor)
            case .revealed:
                let fontSize = CGFloat(Double(tileSize) * 0.75)
                ZStack {
                    TileBackgroundView(size: tileSize, color: filledColor)
                    Text(tileCell.tile.letter)
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

struct AirTileView: View {
    var size: Int
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .frame(width: CGFloat(size), height: CGFloat(size))
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(tileCell: TileCell(id: 0, tile: Tile.WRevealed), tileSize: 40, filledColor: Color.purple)
    }
}
