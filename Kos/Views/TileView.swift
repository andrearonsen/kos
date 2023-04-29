//
//  Tile.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import SwiftUI

struct TileView: View {
    var tile: TileCell
    let tileSize: Int
    let filledColor: Color
    
    var body: some View {
        let fontSize = CGFloat(Double(tileSize) * 0.75)
        ZStack {
            TileBackgroundView(size: tileSize, color: tile.state == .hidden ? GameColors.background : filledColor)
                .opacity(tile.state == .empty ? 0 : 1.0)
            Text(tile.letter)
                .bold()
                .font(.system(size: fontSize))
                .foregroundColor(GameColors.foreground)
                .opacity(tile.state == .revealed ? 1.0 : 0)
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
            .shadow(radius: 1)
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TileView(tile: TileCell(row: 0, col: 0, letter: "W", state: .hidden), tileSize: 40, filledColor: Color.purple)
                .previewDisplayName("Hidden")
            TileView(tile: TileCell(row: 0, col: 0, letter: "W", state: .revealed), tileSize: 40, filledColor: Color.purple)
                .previewDisplayName("Revealed")
            TileView(tile: TileCell(row: 0, col: 0, letter: "W", state: .empty), tileSize: 40, filledColor: Color.purple)
                .previewDisplayName("Empty")
        }
        
    }
}
