//
//  TileRow.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 29/04/2023.
//

import Foundation

struct TileRow: Identifiable {
    let id: Int
    let tiles: [TileCell]
    
    func revealTile(tile: TileIndex) -> TileRow {
        let tileCell = tiles[tile.col]
        var t = tiles
        t[tileCell.col] = tileCell.revealed()
        return TileRow(id: id, tiles: t)
    }
    
}
