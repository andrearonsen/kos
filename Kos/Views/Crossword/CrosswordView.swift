//
//  CrosswordView.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 23/04/2023.
//

import SwiftUI

struct CrosswordView: View {
    @EnvironmentObject var gameData: GameData
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let nrCols = gameData.game.board.nrCols
            let tileSize = Int(width / Double(nrCols + 1))
            let padding = CGFloat(tileSize / 2)
            let tileColor = gameData.game.gameColor
            let tileRows = gameData.game.board.rows
            
            Grid(alignment: .top, horizontalSpacing: 1, verticalSpacing: 1) {
                ForEach(tileRows) { tileRow in
                    GridRow {
                        ForEach(tileRow.tiles) { tileCell in
                            TileView(tile: tileCell, tileSize: tileSize, filledColor: tileColor)
                                .animation(.spring(), value: tileCell.state)
                        }
                    }
                }
            }.padding([.all], padding)
        }
    }
}

struct CrosswordView_Previews: PreviewProvider {
    static var gameData: GameData = GameData()
    
    static var previews: some View {
        CrosswordView()
            .environmentObject(gameData)
            .previewDisplayName("Start")
            .gesture(TapGesture()
                .onEnded {
                    gameData.game.previewRevealAllWords()
                }
            )
    }
}
