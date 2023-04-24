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
            let tileSize = Int(width / Double(nrCols + 2))
            let tileColor = game.currentColor
            let tileRows = game.currentBoard.startTileRows()
            
            Grid(alignment: .top, horizontalSpacing: 1, verticalSpacing: 1) {
                ForEach(tileRows) { tileRow in
                    GridRow {
                        ForEach(tileRow.tiles) { tileCell in
                            TileView(tileCell: tileCell, tileSize: tileSize, filledColor: tileColor) }
                        }
                    }
            }.padding(50)
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
