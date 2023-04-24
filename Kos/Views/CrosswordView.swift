//
//  CrosswordView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import SwiftUI

struct CrosswordView: View {
    @State var game: Game
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let nrCols = game.currentBoard.nrCols()
            let nrRows = game.currentBoard.nrRows()
            let tileSize = Int(width / Double(nrCols))
            let tileColor = game.currentColor
            let tiles = game.currentBoard.tiles()
            Grid(alignment: .top, horizontalSpacing: 1, verticalSpacing: 1) {
//                ForEach(tiles) { tileRow in
//
//                }
                GridRow {
                    ForEach(0..<2) { _ in
                        TileView(forTile: Tile.empty, tileSize: tileSize, filledColor: tileColor) }
                    }
                GridRow {
                    ForEach(0..<5) { _ in
                        TileView(forTile: Tile.A, tileSize: tileSize, filledColor: tileColor)
                    }
                }
                GridRow {
                    ForEach(0..<4) { _ in
                        TileView(forTile: Tile.empty, tileSize: tileSize, filledColor: tileColor)
                    }
                }
            }
    //        .gridCellUnsizedAxes(.vertical)
    //        .gridCellUnsizedAxes(.horizontal)
        }
    }
}

struct CrosswordView_Previews: PreviewProvider {
    static let game = Game.startNewGame()

    static var previews: some View {
        CrosswordView(game: game)
//            .environmentObject(modelData)
    }
}
