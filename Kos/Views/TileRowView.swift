//
//  TileRowView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 29/04/2023.
//

import SwiftUI

struct TileRowView: View {
    var tileRow: TileRow
    let tileSize: Int
    let filledColor: Color
    
    var body: some View {
        ForEach(tileRow.tiles) { tile in
            TileView(tile: tile, tileSize: tileSize, filledColor: filledColor)
        }
    }
}

struct TileRowView_Previews: PreviewProvider {
    static var tileSize: Int = 60
    static var filledColor: Color = Color.green
    static var tileRowHidden = TileRow(
        id: 1,
        tiles: [
            TileCell(row: 1, col: 0, letter: "R", state: .hidden),
            TileCell(row: 1, col: 1, letter: "A", state: .hidden),
            TileCell(row: 1, col: 2, letter: "M", state: .hidden),
            TileCell(row: 1, col: 3, letter: "P", state: .hidden),
        ]
    )
    static var tileRowRevealed = TileRow(
        id: 1,
        tiles: [
            TileCell(row: 1, col: 0, letter: "R", state: .revealed),
            TileCell(row: 1, col: 1, letter: "U", state: .revealed),
            TileCell(row: 1, col: 2, letter: "S", state: .revealed),
            TileCell(row: 1, col: 3, letter: "T", state: .revealed),
        ]
    )
    static var previews: some View {
        Grid {
            GridRow {
                TileRowView(tileRow: tileRowHidden, tileSize: tileSize, filledColor: filledColor)
            }
            GridRow {
                TileRowView(tileRow: tileRowRevealed, tileSize: tileSize, filledColor: filledColor)
            }
        }
        
    }
}
