//
//  LevelDisplay.swift
//  Kos
//
//  Created by André Fagerlie Aronsen on 01/05/2023.
//

import SwiftUI

struct LevelDisplay: View {
    let level: Int
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "graduationcap")
                    .foregroundColor(GameColors.foreground)
                Text("\(level)")
                    .bold()
                    .foregroundColor(GameColors.foreground)
                    .font(.system(size: 20))
            }
            .padding([.leading, .trailing], 10)
            .padding([.top, .bottom], 5)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(GameColors.defaultGameColor)
            )
            
            Spacer()
        }
        .padding([.leading], 20)
    }
}

struct LevelDisplay_Previews: PreviewProvider {
    static var previews: some View {
        LevelDisplay(level: 13)
    }
}
