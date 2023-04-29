//
//  CrosswordView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import SwiftUI

struct CrosswordView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let nrCols = modelData.game.currentBoard.nrCols
            let tileSize = Int(width / Double(nrCols + 1))
            let padding = CGFloat(tileSize / 2)
            let tileColor = modelData.game.currentColor
            let tileRows = modelData.game.currentBoard.rows
            
            Grid(alignment: .top, horizontalSpacing: 1, verticalSpacing: 1) {
                ForEach(tileRows) { tileRow in
                    GridRow {
                        ForEach(tileRow.tiles) { tileCell in
                            TileView(tile: tileCell, tileSize: tileSize, filledColor: tileColor) }
                        }
                    }
            }.padding([.all], padding)
        }
    }
}

struct CrosswordView_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        CrosswordView()
            .environmentObject(modelData)
    }
}
