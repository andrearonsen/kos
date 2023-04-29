//
//  CrosswordView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import SwiftUI

struct CrosswordView: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var crosswordData: CrosswordData
    
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
                            TileView(tile: tileCell, tileSize: tileSize, filledColor: tileColor)
                        }
                    }
                }
            }.padding([.all], padding)
        }
    }
}

struct CrosswordView_Previews: PreviewProvider {
    static var modelData: ModelData = ModelData()
    
    static var modelDataRevealed: ModelData {
        let md = ModelData()
        md.game.previewRevealAllWords()
        return md
    }
    
    static var previews: some View {
        CrosswordView()
            .environmentObject(CrosswordData(previewReveal: false))
            .environmentObject(modelData)
            .previewDisplayName("Start")
            .gesture(TapGesture()
                .onEnded {
                    modelData.game.previewRevealAllWords()
                }
            )
    }
}
