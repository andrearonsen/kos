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
    
    var body: some View {
        if tileCell.state == .empty {
            AirTileView(size: tileSize)
        } else {
            let fontSize = CGFloat(Double(tileSize) * 0.75)
            ZStack {
                TileBackgroundView(size: tileSize, color: tileCell.state == .hidden ? GameColors.background : filledColor)
                Text(tileCell.letter)
                    .bold()
                    .font(.system(size: fontSize))
                    .foregroundColor(GameColors.foreground)
                    .opacity(tileCell.state == .hidden ? 0 : 1.0)
                    
            }
        }
        
//        switch tileCell.state {
//            case .empty:
//                AirTileView(size: tileSize)
//            case .hidden:
//                TileBackgroundView(size: tileSize, color: GameColors.background)
//            case .revealed:
//                let fontSize = CGFloat(Double(tileSize) * 0.75)
//                ZStack {
//                    TileBackgroundView(size: tileSize, color: filledColor)
//                    Text(tileCell.letter)
//                        .bold()
//                        .font(.system(size: fontSize))
//                        .foregroundColor(GameColors.foreground)
//                        
//                }
//        }
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
        TileView(tileCell: TileCell(row: 0, col: 0, letter: "", state: .revealed), tileSize: 40, filledColor: Color.purple)
    }
}
